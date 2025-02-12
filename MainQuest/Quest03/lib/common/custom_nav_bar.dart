import 'package:flutter/material.dart';
import '../home_screen.dart';
import '../food/food_photo_screen.dart';
import '../shopping/menu_screen.dart';
import '../shopping/order_screen.dart';
import '../exercise/exercise_schedule_screen.dart'; // 운동 스케줄 페이지

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomNavBar({required this.currentIndex, required this.onTap});

  void _handleNavigation(BuildContext context, int index) {
    Widget targetScreen;
    switch (index) {
      case 0:
        targetScreen = HomeScreen();
        break;
      case 1:
        targetScreen = FoodPhotoScreen(); // 음식 주문 화면 추가
        break;
      case 2:
        targetScreen = MenuScreen();
        break;
      case 3:
        targetScreen = ExerciseScheduleScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood), // 음식 아이콘 추가
          label: '음식',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          label: '메뉴',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: '운동',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.blueAccent,
      onTap: (index) => _handleNavigation(context, index),
    );
  }
}
