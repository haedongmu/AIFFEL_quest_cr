import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 숫자 포맷을 위해 추가
import 'order_screen.dart';
import '../common/custom_nav_bar.dart';
import '../common/custom_app_bar.dart';
import '../common/app_drawer.dart'; // 서랍 위젯을 import

class MenuDetailScreen extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> menuItems;

  MenuDetailScreen({required this.category, required this.menuItems});

  final NumberFormat _numberFormat = NumberFormat('#,###'); // 숫자 포맷터 추가

  @override
  Widget build(BuildContext context) {
    // 만약 menuItems에 'date' 필드가 있다면 최근순 정렬 (없다면 정렬 생략)
    final sortedMenuItems = List<Map<String, dynamic>>.from(menuItems);
    if (sortedMenuItems.isNotEmpty && sortedMenuItems.first.containsKey('date')) {
      sortedMenuItems.sort((a, b) {
        final dateA = DateTime.parse(a['date'] as String);
        final dateB = DateTime.parse(b['date'] as String);
        return dateB.compareTo(dateA); // 내림차순 정렬
      });
    }

    return Scaffold(
      drawer: AppDrawer(),
      appBar: CustomAppBar(title: '$category 메뉴'),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: sortedMenuItems.length,
        itemBuilder: (context, index) {
          final item = sortedMenuItems[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: item['image'] != null
                  ? Image.asset(
                item['image'] as String,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              )
                  : Container(
                width: 60,
                height: 60,
                color: Colors.grey,
                child: Icon(Icons.image, color: Colors.white),
              ),
              title: Text(
                item['name'] ?? '이름 없음',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${_numberFormat.format(item['price'] ?? 0)}원 | ${_numberFormat.format(item['kcal'] ?? 0)} kcal',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderScreen(
                      itemName: item['name'] ?? '이름 없음',
                      price: item['price'] ?? 0,
                      kcal: item['kcal'] ?? 0,
                      image: item['image'] ?? '',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 2,
        onTap: (index) {
          // 네비게이션 동작 추가 가능
        },
      ),
    );
  }
}
