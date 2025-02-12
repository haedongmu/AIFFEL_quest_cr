import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_nav_bar.dart';
import '../common/app_drawer.dart';
import '../food/food_diary_logic.dart';

class FoodDiaryScreen extends StatefulWidget {
  @override
  _FoodDiaryScreenState createState() => _FoodDiaryScreenState();
}

class _FoodDiaryScreenState extends State<FoodDiaryScreen> {
  late FoodDiaryLogic _foodDiaryLogic;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _foodDiaryLogic = FoodDiaryLogic();
    _loadFoodDiary();
  }

  Future<void> _loadFoodDiary() async {
    await _foodDiaryLogic.loadFoodDiaryByDate(_selectedDate);
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _loadFoodDiary();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '📔 음식일기'),
      drawer: AppDrawer(),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ✅ 날짜 선택 영역
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "날짜: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () => _selectDate(context),
                  icon: Icon(Icons.calendar_today, size: 18),
                  label: Text("날짜 선택"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    backgroundColor: Colors.teal, // ✅ 날짜 선택 버튼 색상 유지
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12), // ✅ 간격 조정

            /// ✅ 식단표
            Table(
              border: TableBorder.all(color: Colors.grey, width: 0.5),
              columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.indigo.withOpacity(0.3)), // ✅ 테이블 헤더 색상 유지
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('구분', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('식단', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
                ..._foodDiaryLogic.categorizedFoodDiary.entries.map((entry) {
                  return TableRow(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(entry.key, textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: entry.value.isNotEmpty
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: entry.value.expand((diary) => diary["foods"]).map<Widget>((food) {
                            return Text('- ${food["food_type"]} ${food["quantity"]}개 (${food["calories"]} kcal)',
                                style: TextStyle(fontSize: 14));
                          }).toList(),
                        )
                            : Text('-', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}
