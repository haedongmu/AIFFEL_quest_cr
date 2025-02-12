import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../food/food_photo_screen.dart'; // 음식촬영
import '../food/food_diary_screen.dart'; // 음식일기
import '../shopping/order_history_screen.dart';      // 주문 내역 페이지
import '../exercise/exercise_schedule_screen.dart';  // 운동 스케줄 페이지
import '../shopping/payment_screen.dart';            // 장바구니 페이지
import '../shopping/menu_screen.dart';               // 메뉴 페이지
import '../exercise/exercise_settings_screen.dart';  // 즐기는 운동 설정 페이지
import '../setting/language_selection_screen.dart'; // 언어 선택 페이지
import '../setting/theme_selection_screen.dart';    // 테마 선택 페이지
import '../setting/profile_settings.dart';    // 개인설정 페이지

class AppDrawer extends StatelessWidget {
  Future<String?> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('profile_data');
    if (savedData != null) {
      final loadedProfile = jsonDecode(savedData);
      return loadedProfile['profileImage']; // 저장된 프로필 이미지 경로 반환
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          FutureBuilder<String?>(
            future: _loadProfileImage(),
            builder: (context, snapshot) {
              String? profileImagePath = snapshot.data;
              ImageProvider imageProvider = (profileImagePath != null && profileImagePath.isNotEmpty)
                  ? FileImage(File(profileImagePath)) as ImageProvider
                  : AssetImage('images/profile_placeholder.png');

              return Container(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orangeAccent, Colors.deepOrange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: imageProvider, // ✅ 저장된 프로필 이미지 적용
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '안녕하세요!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      '쿠키앤다이어트에 오신 것을 환영합니다 🍪',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              );
            },
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildSectionTitleWithIcon('음식', Icons.fastfood),
                _buildDrawerItem(
                  icon: Icons.camera_alt,
                  title: '음식촬영',
                  context: context,
                  screen: FoodPhotoScreen(),
                ),
                _buildDrawerItem(
                  icon: Icons.book,
                  title: '음식일기',
                  context: context,
                  screen: FoodDiaryScreen(),
                ),

                Divider(),

                _buildSectionTitleWithIcon('상점', Icons.store),
                _buildDrawerItem(
                  icon: Icons.restaurant_menu,
                  title: '메뉴',
                  context: context,
                  screen: MenuScreen(),
                ),
                _buildDrawerItem(
                  icon: Icons.shopping_cart,
                  title: '장바구니',
                  context: context,
                  screen: PaymentScreen(),
                ),
                _buildDrawerItem(
                  icon: Icons.receipt_long,
                  title: '주문 내역',
                  context: context,
                  screen: OrderHistoryScreen(),
                ),

                Divider(),

                _buildSectionTitleWithIcon('운동', Icons.fitness_center),
                _buildDrawerItem(
                  icon: Icons.fitness_center,
                  title: '운동 스케줄',
                  context: context,
                  screen: ExerciseScheduleScreen(),
                ),
                _buildDrawerItem(
                  icon: Icons.sports_kabaddi,
                  title: '즐기는 운동 설정',
                  context: context,
                  screen: ExerciseSettingsScreen(),
                ),

                Divider(),

                _buildSectionTitleWithIcon('설정', Icons.settings),
                _buildDrawerItem(
                  icon: Icons.language,
                  title: '언어 선택',
                  context: context,
                  screen: LanguageSelectionScreen(),
                ),
                _buildDrawerItem(
                  icon: Icons.palette,
                  title: '테마 선택',
                  context: context,
                  screen: ThemeSelectionScreen(),
                ),
                _buildDrawerItem(
                  icon: Icons.manage_accounts,
                  title: '개인 설정',
                  context: context,
                  screen: ProfileSettingsScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitleWithIcon(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orangeAccent),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title, required BuildContext context, required Widget screen}) {
    return ListTile(
      leading: Icon(icon, color: Colors.orangeAccent),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}

