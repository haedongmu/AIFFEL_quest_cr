import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_nav_bar.dart';
import '../common/app_drawer.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderDetailScreen({required this.order});

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  final NumberFormat _currencyFormat = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    // 주문 데이터에서 날짜, 총 금액, 아이템 목록을 추출합니다.
    DateTime orderDate = DateTime.parse(order['date']);
    int total = order['total'] as int;
    List<dynamic> items = order['items'] as List<dynamic>;

    return Scaffold(
      // 모든 페이지에서 공통으로 사용할 서랍 메뉴
      drawer: AppDrawer(),
      appBar: CustomAppBar(title: '주문 상세내역'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '주문일시: ${_dateFormat.format(orderDate)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '총 금액: ${_currencyFormat.format(total)}원',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(height: 32, thickness: 2),
            Text(
              '주문 항목',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  Map<String, dynamic> item =
                  items[index] as Map<String, dynamic>;
                  return ListTile(
                    leading: item['image'] != null
                        ? Image.asset(
                      item['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[300],
                    ),
                    title: Text(
                      item['itemName'] ?? '이름 없음',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '가격: ${_currencyFormat.format(item['price'])}원  /  수량: ${item['quantity']}개',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 2, // 필요에 따라 현재 탭 인덱스를 조정하세요.
        onTap: (index) {
          // 네비게이션 동작을 구현합니다.
        },
      ),
    );
  }
}

