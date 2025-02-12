import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_nav_bar.dart';
import 'order_detail_screen.dart'; // 주문 상세내역 페이지 임포트
import '../common/app_drawer.dart'; // 서랍 위젯을 임포트합니다.

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = true;

  // 날짜, 금액 포맷터
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  final NumberFormat _currencyFormat = NumberFormat('#,###');

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> orderStrings = prefs.getStringList('orderHistory') ?? [];
    print(orderStrings);
    List<Map<String, dynamic>> orders = orderStrings
        .map((order) => jsonDecode(order) as Map<String, dynamic>)
        .toList();

    // 주문일시 기준 내림차순 정렬
    orders.sort((a, b) => DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));

    setState(() {
      _orders = orders;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(), // 서랍(드로어) 추가
      appBar: CustomAppBar(title: '주문 내역'),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _orders.isEmpty
            ? Center(
          child: Text(
            '주문 내역이 없습니다.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
            : ListView.builder(
          itemCount: _orders.length,
          itemBuilder: (context, index) {
            var order = _orders[index];
            DateTime orderDate = DateTime.parse(order['date']);
            int total = order['total'] as int;
            List<dynamic> items = order['items'] as List<dynamic>;

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  '주문일시: ${_dateFormat.format(orderDate)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('총 금액: ${_currencyFormat.format(total)}원'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // 상세 주문내역 페이지로 이동 (order 데이터를 전달)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailScreen(order: order),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 3, // 필요에 따라 탭 순서를 조정하세요.
        onTap: (index) {
          // CustomNavBar 내부 네비게이션 로직에 따라 처리합니다.
        },
      ),
    );
  }
}
