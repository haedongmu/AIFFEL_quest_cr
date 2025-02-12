import '../food/food_diary_storage.dart';
import 'package:intl/intl.dart';

class FoodDiaryLogic {
  Map<String, List<Map<String, dynamic>>> categorizedFoodDiary = {
    "아침 (오전 6시 ~ 오전 9시)": [],
    "점심 (오전 11시 ~ 오후 2시)": [],
    "저녁 (오후 5시 ~ 오후 7시)": [],
    "간식 (나머지 시간)": [],
  };

  Future<void> loadFoodDiaryByDate(DateTime date) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    List<Map<String, dynamic>> diaryEntries = await FoodDiaryStorage.loadFoodDiary();
    print("📌 불러온 전체 음식일기 데이터: $diaryEntries");

    if (diaryEntries.isNotEmpty) {
      List<Map<String, dynamic>> selectedDateEntries = diaryEntries.where((entry) => entry["date"] == formattedDate).toList();
      print("📌 선택한 날짜(${formattedDate})의 음식일기 데이터: $selectedDateEntries");

      categorizedFoodDiary.forEach((key, value) => value.clear()); // 기존 데이터 초기화
      _categorizeFoodDiary(selectedDateEntries);
    }
  }

  void _categorizeFoodDiary(List<Map<String, dynamic>> diaryEntries) {
    for (var diary in diaryEntries) {
      print("📌 분류할 데이터: $diary");
      String mealType = _determineMealType(diary["time"]);
      categorizedFoodDiary[mealType]?.add(diary);
    }
    print("📌 분류된 음식일기 데이터: $categorizedFoodDiary");
  }

  String _determineMealType(String time) {
    List<String> parts = time.split(":");
    int hour = int.parse(parts[0]);

    if (hour >= 6 && hour < 9) {
      return "아침 (오전 6시 ~ 오전 9시)";
    } else if (hour >= 11 && hour < 14) {
      return "점심 (오전 11시 ~ 오후 2시)";
    } else if (hour >= 17 && hour < 19) {
      return "저녁 (오후 5시 ~ 오후 7시)";
    } else {
      return "간식 (나머지 시간)";
    }
  }
}
