import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/base_scaffold.dart';
import '../common/cart_icon.dart';
import '../common/custom_nav_bar.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<Map<String, dynamic>> _cartItems = [];
  bool _isLoading = true;

  // 세 자리 콤마 포맷터
  final NumberFormat _currencyFormat = NumberFormat('#,###');

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartStringList = prefs.getStringList('cart') ?? [];
    List<Map<String, dynamic>> cartList = cartStringList
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
    setState(() {
      _cartItems = cartList;
      _isLoading = false;
    });

    // 운동 스케줄이 저장되어 있다면 출력합니다.
    _printStoredExerciseSchedule();
  }

  Future<void> _printStoredExerciseSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedSchedule = prefs.getString('exercise_schedule');
    if (storedSchedule != null) {
      print("Stored exercise_schedule: $storedSchedule");
    } else {
      print("No exercise_schedule found in SharedPreferences.");
    }
  }

  // SharedPreferences에 현재 _cartItems 값을 저장하고 전역 notifier 업데이트
  Future<void> _updateCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> updatedCart =
    _cartItems.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('cart', updatedCart);
    CartIcon.cartItemsNotifier.value = updatedCart;
  }

  // 아이템 삭제 함수
  void _deleteItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    _updateCart();
  }

  // 총 결제 금액 계산 함수
  int _calculateTotal() {
    int total = 0;
    for (var item in _cartItems) {
      total += (item['price'] as int) * (item['quantity'] as int);
    }
    return total;
  }

  // 결제하기 버튼을 누르면 확인 다이얼로그 후 주문 완료 처리
  void _processPayment() {
    int totalPrice = _calculateTotal();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('결제 확인'),
        content: Text(
            '총 결제금액 ${_currencyFormat.format(totalPrice)}원 결제를 진행하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 다이얼로그 닫기
            },
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // 다이얼로그 닫기
              await _completePayment(); // 주문 완료 처리
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  // 주문 완료 처리: 주문 내역 등록 후 카트 내용 비우기 및 결제 관련 데이터 저장
  Future<void> _completePayment() async {
    int totalPrice = _calculateTotal();
    int totalKcal = 0;
    for (var item in _cartItems) {
      totalKcal += (item['kcal'] as int) * (item['quantity'] as int);
    }
    final prefs = await SharedPreferences.getInstance();

    // 기존 운동 스케줄 데이터 초기화 (새 결제이므로 새 스케줄 생성)
    //await prefs.remove('exercise_schedule');
    //await prefs.setBool('exercise_schedule_confirmed', false);

    // 서울 기준 주문 시각 생성 (UTC 기준 +9시간)
    final orderTime = DateTime.now().toUtc().add(Duration(hours: 9));
    String uniqueId = orderTime.millisecondsSinceEpoch.toString();

    // 주문 내역 데이터 생성
    Map<String, dynamic> newOrder = {
      'date': orderTime.toIso8601String(),
      'total': totalPrice,
      'totalKcal': totalKcal, // 여기서 총 칼로리 값을 함께 저장
      'items': _cartItems,
      'scheduleCreated': false, // 운동 스케줄이 아직 생성되지 않았음을 표시
    };

    List<String> orderHistory = prefs.getStringList('orderHistory') ?? [];
    orderHistory.add(jsonEncode(newOrder));
    await prefs.setStringList('orderHistory', orderHistory);

    // 카트 내용 비우기
    await prefs.setStringList('cart', []);
    CartIcon.cartItemsNotifier.value = [];
    setState(() {
      _cartItems = [];
    });

    // 새 결제에 해당하는 운동 스케줄 생성을 위한 데이터 저장
    await prefs.setInt('order_total_kcal_$uniqueId', totalKcal);
    await prefs.setString('order_date_$uniqueId', orderTime.toIso8601String());
    await prefs.setBool('exercise_schedule_confirmed', false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('결제가 완료되었습니다!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = _calculateTotal();
    return BaseScaffold(
      title: '장바구니',
      bottomNavigationBar: CustomNavBar(
        currentIndex: 2,
        onTap: (index) {
          // 네비게이션 동작 구현 (필요 시)
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _cartItems.isEmpty
            ? Center(
          child: Text(
            '장바구니가 비어있습니다.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        )
            : Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: _cartItems.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: 12),
                itemBuilder: (context, index) {
                  var item = _cartItems[index];
                  String imagePath = item['image'] is String
                      ? item['image'] as String
                      : 'images/default.png';
                  String itemName = item['itemName'] is String
                      ? item['itemName'] as String
                      : '이름 없음';
                  int price = item['price'] is int
                      ? item['price'] as int
                      : 0;
                  int kcal = item['kcal'] is int
                      ? item['kcal'] as int
                      : 0;
                  int quantity = item['quantity'] is int
                      ? item['quantity'] as int
                      : 1;
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              imagePath,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itemName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '가격: ${_currencyFormat.format(price)}원',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    // 수량 수정 Row
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons
                                              .remove_circle_outline),
                                          onPressed: () {
                                            if (quantity > 1) {
                                              setState(() {
                                                item['quantity'] =
                                                    quantity - 1;
                                              });
                                              _updateCart();
                                            }
                                          },
                                        ),
                                        Text(
                                          '$quantity',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons
                                              .add_circle_outline),
                                          onPressed: () {
                                            setState(() {
                                              item['quantity'] =
                                                  quantity + 1;
                                            });
                                            _updateCart();
                                          },
                                        ),
                                      ],
                                    ),
                                    // 삭제 버튼
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        _deleteItem(index);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 16.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '총 결제금액',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${_currencyFormat.format(totalPrice)}원',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '결제하기',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
