import 'package:flutter/material.dart';
import '../common/custom_nav_bar.dart';
import 'menu_items.dart';
import 'menu_detail_screen.dart';
import '../common/custom_app_bar.dart';
import '../common/app_drawer.dart'; // 서랍 위젯을 import

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // 네비게이션 이동 로직 추가 가능
    });
  }

  final List<Map<String, String>> menuCategories = [
    {'name': '빵', 'image': 'images/menu/bread/icon.png'},
    {'name': '케이크', 'image': 'images/menu/cake/icon.png'},
    {'name': '치킨', 'image': 'images/menu/chicken/icon.png'},
    {'name': '디저트', 'image': 'images/menu/disert/icon.png'},
    {'name': '음료', 'image': 'images/menu/drink/icon.png'},
    {'name': '아이스크림', 'image': 'images/menu/icecream/icon.png'},
    {'name': '피자', 'image': 'images/menu/pizza/icon.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: CustomAppBar(title: '메뉴'),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: menuCategories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              String category = menuCategories[index]['name']!;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuDetailScreen(
                    category: category,
                    menuItems: menuItems[category] ?? [],
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    menuCategories[index]['image']!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text(
                    menuCategories[index]['name']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 2,
        onTap: _onItemTapped,
      ),
    );
  }
}