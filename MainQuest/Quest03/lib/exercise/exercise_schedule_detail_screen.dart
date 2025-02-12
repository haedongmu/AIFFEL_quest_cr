import 'package:flutter/material.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_nav_bar.dart';
import '../common/app_drawer.dart';
import 'exercise_data.dart';

class ExerciseScheduleDetailScreen extends StatelessWidget {
  final Map<String, dynamic> scheduleData;

  const ExerciseScheduleDetailScreen({required this.scheduleData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: CustomAppBar(title: '운동 스케줄 상세'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (scheduleData.containsKey('days'))
              ..._buildDayList(scheduleData['days'] as List<dynamic>),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentIndex: 3, onTap: (index) {}),
    );
  }

  List<Widget> _buildDayList(List<dynamic> days) {
    return days.map((day) => Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Day ${day['day']} (${day['date']})',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 1, color: Colors.grey),
            SizedBox(height: 8),
            ..._buildExerciseList(day['exercises'] as List<dynamic>),
          ],
        ),
      ),
    )).toList();
  }

  List<Widget> _buildExerciseList(List<dynamic> exercises) {
    return exercises.map((exercise) {
      final imagePath = exerciseData.firstWhere(
            (data) => data['name'] == exercise['exercise'],
        orElse: () => {'image': 'images/health/default.png'},
      )['image'];

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.cover),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise['exercise'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('${exercise['duration']}분 (소모 : ${exercise['calories']} kcal)',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }
}
