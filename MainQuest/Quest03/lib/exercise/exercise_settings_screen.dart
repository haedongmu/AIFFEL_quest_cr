// exercise_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../common/custom_nav_bar.dart';
import '../common/custom_app_bar.dart';
import '../common/app_drawer.dart';
import 'exercise_data.dart'; // 별도로 분리한 운동 데이터 파일을 import

class ExerciseSettingsScreen extends StatefulWidget {
  @override
  _ExerciseSettingsScreenState createState() => _ExerciseSettingsScreenState();
}

class _ExerciseSettingsScreenState extends State<ExerciseSettingsScreen> {
  // 이제 운동 종목 정보는 exerciseData 변수를 그대로 사용합니다.
  // 복사본을 만들어 로컬에서 수정할 수 있도록 합니다.
  List<Map<String, dynamic>> exercises = List<Map<String, dynamic>>.from(exerciseData);

  @override
  void initState() {
    super.initState();
    _loadSelectedExercises();
  }

  Future<void> _loadSelectedExercises() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('selected_exercises');
    if (savedData != null) {
      List<dynamic> savedList = jsonDecode(savedData);
      setState(() {
        for (var exercise in exercises) {
          exercise['selected'] = savedList.contains(exercise['name']);
        }
      });
    }
  }

  Future<void> _saveSelectedExercises() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> selectedList = exercises
        .where((exercise) => exercise['selected'] == true)
        .map((exercise) => exercise['name'] as String)
        .toList();
    await prefs.setString('selected_exercises', jsonEncode(selectedList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: CustomAppBar(title: '즐기는 운동 설정'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ListTile(
                leading: Image.asset(
                  exercises[index]['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  exercises[index]['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: Checkbox(
                  value: exercises[index]['selected'],
                  onChanged: (bool? value) {
                    setState(() {
                      exercises[index]['selected'] = value!;
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 3,
        onTap: (index) {
          // 네비게이션 동작 추가 가능
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _saveSelectedExercises();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('운동 설정이 저장되었습니다!')),
          );
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.green,
      ),
    );
  }
}

