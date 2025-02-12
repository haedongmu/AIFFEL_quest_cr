import 'package:flutter/material.dart';

class EditableFoodTable extends StatefulWidget {
  final List<Map<String, dynamic>> initialFoods;

  const EditableFoodTable({Key? key, required this.initialFoods}) : super(key: key);

  @override
  EditableFoodTableState createState() => EditableFoodTableState(); // ✅ public으로 변경
}

class EditableFoodTableState extends State<EditableFoodTable> {
  List<Map<String, dynamic>> _editableFoods = [];

  @override
  void initState() {
    super.initState();

    _editableFoods = [];

    // ✅ 분석 결과 데이터를 _editableFoods에 추가
    for (var food in widget.initialFoods) {
      _editableFoods.add({
        "food_type": food["food_type"] ?? "",
        "quantity": food["quantity"]?.toString() ?? "",
        "calories": food["calories"]?.toString() ?? ""
      });
    }
  }

  /// 📌 현재 입력된 데이터를 반환하는 함수
  List<Map<String, dynamic>> getUpdatedFoods() {
    return _editableFoods;
  }

  /// 📌 표 데이터 업데이트 함수 추가
  void updateFoods(List<Map<String, dynamic>> newFoods) {
    setState(() {
      _editableFoods = List<Map<String, dynamic>>.from(newFoods);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "📊 음식 분석 결과 수정",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),

        Table(
          border: TableBorder.all(color: Colors.black26, width: 1),
          columnWidths: {
            0: FlexColumnWidth(3), // 음식명
            1: FlexColumnWidth(2), // 개수
            2: FlexColumnWidth(3), // 칼로리
          },
          children: [
            // 📌 테이블 헤더
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[200]),
              children: [
                _tableHeader("음식명"),
                _tableHeader("개수"),
                _tableHeader("kcal"),
              ],
            ),
            // 📌 데이터 입력 행 (초기 데이터 기반)
            for (int i = 0; i < _editableFoods.length; i++)
              TableRow(
                children: [
                  _tableEditableCell(i, "food_type"),
                  _tableEditableCell(i, "quantity"),
                  _tableEditableCell(i, "calories"),
                ],
              ),
          ],
        ),
      ],
    );
  }

  /// 📌 테이블 헤더 스타일
  Widget _tableHeader(String title) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// 📌 수정 가능한 셀 (입력 필드)
  Widget _tableEditableCell(int index, String fieldKey) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: TextFormField(
        initialValue: _editableFoods[index][fieldKey].toString(),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          isDense: true,
        ),
        onChanged: (value) {
          setState(() {
            _editableFoods[index][fieldKey] = value;
          });
        },
      ),
    );
  }
}
