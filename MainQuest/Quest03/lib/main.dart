import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shopping/payment_screen.dart'; // PaymentScreen 추가

void main() {
  runApp(CookieNDietApp());
}

class CookieNDietApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      routes: {
        '/payment': (context) => PaymentScreen(), // PaymentScreen 라우트 등록
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: Stack(
          children: [
            // 배경 이미지 (쿠키)
            Positioned.fill(
              child: Image.asset(
                'images/sub_main.png', // 쿠키 배경 이미지 경로
                fit: BoxFit.cover,
              ),
            ),
            // 중앙 운동 이미지
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '쿠키앤다이어트',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black45,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'images/main.png', // 운동 이미지 경로
                    width: 200, // 원하는 크기 조정
                    height: 200,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}