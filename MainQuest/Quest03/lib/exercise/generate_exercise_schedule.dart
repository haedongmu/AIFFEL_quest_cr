import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'exercise_data.dart';
import 'dart:math';
import 'package:intl/intl.dart'; // 날짜 형식 변환을 위한 패키지 추가

Future<void> generateExerciseSchedule() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> orderHistory = prefs.getStringList('orderHistory') ?? [];

  // ✅ 기존 운동 일정 데이터 유지
  List<Map<String, dynamic>> allSchedules = [];
  String? existingSchedulesJson = prefs.getString('exercise_schedule');
  if (existingSchedulesJson != null && existingSchedulesJson.isNotEmpty) {
    try {
      dynamic decodedData = jsonDecode(existingSchedulesJson);
      if (decodedData is List) {
        allSchedules = List<Map<String, dynamic>>.from(decodedData);
      }
    } catch (e) {
      print("Error decoding existing schedules: $e");
    }
  }

  if (orderHistory.isEmpty) {
    print("No order history found.");
    await prefs.setInt('schedule_count', 0);
    return;
  }

  // ✅ 기존에 생성된 운동 일정의 개수 확인
  int scheduleCount = allSchedules.length + 1;

  for (int idx = 0; idx < orderHistory.length; idx++) {
    Map<String, dynamic> orderData = jsonDecode(orderHistory[idx]);

    // ✅ 이미 scheduleCreated가 true이면 스킵
    if (orderData['scheduleCreated'] ?? false) {
      continue;
    }

    print("Processing Order ${idx + 1}: ${orderData['date']}, scheduleCreated: ${orderData['scheduleCreated']}");

    DateTime extractedDate = DateTime.parse(orderData['date']).toLocal();
    int totalKcal = orderData['totalKcal'] ?? 0;

    String? savedExercises = prefs.getString('selected_exercises');
    if (savedExercises != null) {
      List<String> userSelectedExercises = List<String>.from(jsonDecode(savedExercises));
      Map<String, int> exerciseCalorieMap = {};

      for (var exercise in userSelectedExercises) {
        var matchedExercise = exerciseData.firstWhere(
              (e) => e['name'] == exercise,
          orElse: () => {},
        );
        if (matchedExercise.isNotEmpty) {
          exerciseCalorieMap[exercise] = matchedExercise['calories_per_min'] ?? 0;
        }
      }

      List<String> randomExercises = List.from(userSelectedExercises)..shuffle();
      int randomCount = (randomExercises.length > 1) ? Random().nextInt(randomExercises.length - 1) + 1 : 1;
      List<String> selectedRandomExercises = randomExercises.take(randomCount).toList();

      List<int> kcalDistribution = [];
      int baseKcal = totalKcal ~/ selectedRandomExercises.length;
      int remainder = totalKcal % selectedRandomExercises.length;
      for (int i = 0; i < selectedRandomExercises.length; i++) {
        kcalDistribution.add(baseKcal + (i < remainder ? 1 : 0));
      }

      // ✅ schedule_id를 한 번만 생성
      String scheduleId = 'schedule_${DateTime.now().millisecondsSinceEpoch}';

      List<Map<String, dynamic>> exerciseSchedule = [];
      int day = 1;
      int dailyTime = 0;
      List<Map<String, dynamic>> dayExercises = [];
      DateTime currentDate = extractedDate;
      DateFormat dateFormat = DateFormat("M월 d일");

      for (int i = 0; i < selectedRandomExercises.length; i++) {
        String exercise = selectedRandomExercises[i];
        int duration = (kcalDistribution[i] / (exerciseCalorieMap[selectedRandomExercises[i]] ?? 1)).round();
        int caloriesBurned = duration * (exerciseCalorieMap[selectedRandomExercises[i]] ?? 1);

        while (duration > 0) {
          int availableTime = 120 - dailyTime; // 현재 날짜에서 남은 운동 가능 시간
          int addDuration = min(duration, availableTime); // 남은 시간과 현재 운동 시간 중 작은 값 선택

          dayExercises.add({
            'exercise': exercise,
            'duration': addDuration,
            'calories': addDuration * (exerciseCalorieMap[selectedRandomExercises[i]] ?? 1),
          });
          dailyTime += addDuration;
          duration -= addDuration; // 남은 운동 시간 업데이트

          if (dailyTime >= 120) {
            // 하루 최대 운동 시간을 초과하면 새로운 날짜로 넘어감
            exerciseSchedule.add({
              'day': day,
              'date': dateFormat.format(currentDate),
              'exercises': dayExercises,
            });

            day++;
            dailyTime = 0;
            dayExercises = [];
            currentDate = currentDate.add(Duration(days: 1));
          }
        }
      }

      if (dayExercises.isNotEmpty) {
        exerciseSchedule.add({
          'day': day,
          'date': dateFormat.format(currentDate),
          'exercises': dayExercises,
        });
      }

      DateTime startDate = extractedDate;
      DateTime endDate = startDate.add(Duration(days: exerciseSchedule.length - 1));

      String formattedStartDate = dateFormat.format(startDate);
      String formattedEndDate = dateFormat.format(endDate);
      String scheduleTitle = '${scheduleCount}번째 운동 (${formattedStartDate} ~ ${formattedEndDate})';

      Map<String, dynamic> fullSchedule = {
        'schedule_id': scheduleId,
        'title': scheduleTitle,
        'days': exerciseSchedule
      };

      allSchedules.add(fullSchedule);

      // ✅ 해당 주문의 scheduleCreated를 true로 변경하여 다시 생성되지 않도록 설정
      orderData['scheduleCreated'] = true;
      orderHistory[idx] = jsonEncode(orderData);
      await prefs.setStringList('orderHistory', orderHistory);

      scheduleCount++;
    }
  }

  // ✅ 기존 스케줄을 유지하면서 새로운 스케줄을 추가하여 저장
  await prefs.setString('exercise_schedule', jsonEncode(allSchedules));

  print("Generated Exercise Schedules: ${jsonEncode(allSchedules)}");
}
