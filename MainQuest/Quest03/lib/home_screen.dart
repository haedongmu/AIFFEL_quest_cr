import 'package:flutter/material.dart';
import 'common/custom_nav_bar.dart';
import 'shopping/menu_screen.dart';
import 'common/custom_app_bar.dart';
import 'exercise/exercise_settings_screen.dart';
import 'common/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: CustomAppBar(title: '쿠키앤다이어트'),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade200, Colors.orangeAccent, Colors.brown.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ 앱 로고 추가 (쿠키 아이콘)
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/main.png'), // 로고 이미지 추가
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 16),

            // ✅ 부드러운 애니메이션 효과를 주기 위한 AnimatedOpacity
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 1),
              child: Text(
                '🍪 쿠키앤다이어트 🍪',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black26,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            Text(
              '먹고 싶은 음식을 마음껏 먹고,\n운동을 통해 균형을 맞추는 스마트한 다이어트 앱!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30),

            // ✅ 메뉴 보기 버튼 (그라데이션 버튼)
            Container(
              width: 250,
              height: 55,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.deepOrange],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(2, 3),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // 배경 투명 (그라데이션 보이게)
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  '🍽 메뉴 보기',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),

            // ✅ 즐기는 운동 설정 버튼 (강렬한 오렌지-레드 그라데이션)
            Container(
              width: 250,
              height: 55,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF212121), Color(0xFFFFC107)], // 블랙 → 골드
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(2, 3),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExerciseSettingsScreen()),
                  );
                },
                icon: Icon(Icons.fitness_center, size: 30, color: Colors.white),
                label: Text(
                  '💪 즐기는 운동 설정',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // 배경 투명 (그라데이션 효과 유지)
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
