import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_nav_bar.dart';
import '../common/app_drawer.dart';
import 'generate_exercise_schedule.dart';
import 'exercise_schedule_detail_screen.dart';

class ExerciseScheduleScreen extends StatefulWidget {
  @override
  _ExerciseScheduleScreenState createState() => _ExerciseScheduleScreenState();
}

class _ExerciseScheduleScreenState extends State<ExerciseScheduleScreen> {
  List<Map<String, dynamic>> exerciseSchedules = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSchedule();
  }

  Future<void> _initializeSchedule() async {
    await generateExerciseSchedule();
    await _loadScheduleData();
  }

  Future<void> _loadScheduleData() async {
    final prefs = await SharedPreferences.getInstance();
    final scheduleJson = prefs.getString('exercise_schedule');

    if (scheduleJson != null && scheduleJson.isNotEmpty && scheduleJson != '[]') {
      try {
        final decodedSchedule = jsonDecode(scheduleJson);
        if (decodedSchedule is List && decodedSchedule.isNotEmpty) {

          // 제목 기준 내림차순 정렬
          decodedSchedule.sort((a, b) => b['title'].compareTo(a['title']));

          setState(() {
            exerciseSchedules = List<Map<String, dynamic>>.from(decodedSchedule);
            isLoading = false;
          });
          print("운동 스케줄 로드됨: $scheduleJson");
        } else {
          setState(() {
            exerciseSchedules = [];
            isLoading = false;
          });
          print("운동 스케줄 데이터 없음");
        }
      } catch (e) {
        print("JSON 디코딩 오류: $e");
        setState(() {
          exerciseSchedules = [];
          isLoading = false;
        });
      }
    } else {
      setState(() {
        exerciseSchedules = [];
        isLoading = false;
      });
      print("운동 스케줄 데이터 없음");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: CustomAppBar(title: '운동 스케줄'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : exerciseSchedules.isEmpty
              ? _buildNoScheduleMessage()
              : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: exerciseSchedules.length,
                  itemBuilder: (context, index) {
                    var schedule = exerciseSchedules[index];
                    return _buildScheduleCard(schedule);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentIndex: 3, onTap: (index) {}),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> scheduleData) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseScheduleDetailScreen(scheduleData: scheduleData),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        shadowColor: Colors.black26,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Feather.activity, size: 40, color: Colors.orangeAccent),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      scheduleData['title'],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (scheduleData.containsKey('days'))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: scheduleData['days'].map<Widget>((day) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "📅 ${day['date']} - ${day['exercises'].length} 개 운동",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoScheduleMessage() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Feather.alert_circle, size: 50, color: Colors.redAccent),
          SizedBox(height: 10),
          Text(
            '운동 스케줄 데이터 없음\n즐기는 운동 설정 필수!!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
