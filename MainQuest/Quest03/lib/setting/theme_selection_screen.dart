import 'package:flutter/material.dart';

class ThemeSelectionScreen extends StatefulWidget {
  @override
  _ThemeSelectionScreenState createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> {
  bool _isDarkMode = false; // 기본 테마는 라이트 모드

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('테마 선택')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('테마를 선택하세요.', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('다크 모드'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              secondary: Icon(_isDarkMode ? Icons.nights_stay : Icons.wb_sunny),
            ),
          ],
        ),
      ),
    );
  }
}
