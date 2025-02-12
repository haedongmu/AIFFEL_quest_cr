import 'package:flutter/material.dart';
import 'editable_food_table.dart'; // ✅ 분리된 수정 가능 테이블 파일 임포트

class FoodAnalysisResult extends StatefulWidget {
  final List<Map<String, dynamic>> foods;

  const FoodAnalysisResult({Key? key, required this.foods}) : super(key: key);

  @override
  _FoodAnalysisResultState createState() => _FoodAnalysisResultState();
}

class _FoodAnalysisResultState extends State<FoodAnalysisResult> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ 원래 분석 결과 (수정 불가)
        if (widget.foods.isNotEmpty) _buildAnalysisResults(),

        SizedBox(height: 20), // 여백 추가

        // ✅ 수정 가능한 테이블 컴포넌트 추가
        EditableFoodTable(initialFoods: widget.foods),
      ],
    );
  }

  /// 📌 기존 분석 결과 UI (수정 불가)
  Widget _buildAnalysisResults() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.foods.map((food) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              "${food['food_type']} : ${food['calories']} kcal (${food['quantity']}개)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          );
        }).toList(),
      ),
    );
  }
}
