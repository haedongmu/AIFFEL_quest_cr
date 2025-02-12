import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartIcon extends StatefulWidget {
  CartIcon({Key? key}) : super(key: key);

  /// 전역에서 사용 가능한 notifier
  static final ValueNotifier<List<String>> cartItemsNotifier = ValueNotifier([]);

  static Future<void> addToCart(String itemName, int price, int kcal, String image, int quantity) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cart') ?? [];
    List<Map<String, dynamic>> cartList = cartItems
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();

    bool itemExists = false;
    for (var item in cartList) {
      if (item['itemName'] == itemName) {
        item['quantity'] += quantity;
        itemExists = true;
        break;
      }
    }

    if (!itemExists) {
      cartList.add({
        'itemName': itemName,
        'price': price,
        'kcal': kcal,
        'image': image,
        'quantity': quantity,
      });
    }

    List<String> updatedCartItems = cartList.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList('cart', updatedCartItems);

    // 전역 notifier 업데이트: 카트 데이터가 바뀌면 바로 UI에 반영됨
    cartItemsNotifier.value = updatedCartItems;

    // 현재 카트에 담긴 전체 내용 출력
    print('현재 카트 내용:');
    for (String item in updatedCartItems) {
      print(jsonDecode(item));
    }
  }

  @override
  _CartIconState createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    // 초기 카트 데이터를 전역 notifier에 할당
    List<String> storedCart = _prefs.getStringList('cart') ?? [];
    CartIcon.cartItemsNotifier.value = storedCart;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: CartIcon.cartItemsNotifier,
      builder: (context, cartItems, child) {
        int cartItemCount = cartItems.length;
        return Stack(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart, size: 28),
              onPressed: () {
                Navigator.pushNamed(context, '/payment');
              },
            ),
            if (cartItemCount > 0)
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$cartItemCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
