import 'dart:convert'; // JSON 데이터 변환을 위한 라이브러리
import 'package:flutter/material.dart'; // 플러터 UI 프레임워크
import 'package:http/http.dart' as http; // HTTP 요청을 위한 패키지

void main() {
  runApp(MyApp()); // 애플리케이션 실행
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배지 제거
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyHomePage(), // 홈 화면 설정
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = ""; // API 응답 결과를 저장할 변수
  TextEditingController urlController = TextEditingController(); // URL 입력 필드 컨트롤러

  // 예측 결과 요청 함수
  Future<void> fetchPrediction() async {
    await fetchData("sample");
  }

  // 예측 확률 요청 함수
  Future<void> fetchProbability() async {
    await fetchData("probability");
  }

  // API 요청을 처리하는 함수
  Future<void> fetchData(String endpoint) async {
    try {
      final enteredUrl = urlController.text; // 입력된 URL 가져오기
      final response = await http.get(
        Uri.parse(enteredUrl + 'sample'), // API 요청 URL
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );

      print("Response Status Code: \${response.statusCode}");
      print("Response Body: \${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // JSON 데이터 변환
        print("Parsed Data: \$data");

        setState(() {
          result = endpoint == "sample"
              ? "Predicted Label: \${data['predicted_label']}" // 예측 결과 표시
              : "Prediction Probability: \${data['prediction_score'].toString()}"; // 예측 확률 표시
        });
      } else {
        setState(() {
          result = "Failed to fetch data. Status Code: \${response.statusCode}";
        });
      }
    } catch (e) {
      print("Error: \$e");
      setState(() {
        result = "Error: \$e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset('images/jellyfish_icon.png'), // 앱바 왼쪽 아이콘 추가
        ),
        title: Center(
          child: Text(
            "Jellyfish Classifier", // 앱 제목
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true, // 제목 중앙 정렬
        backgroundColor: Colors.blueAccent, // 앱바 배경색 지정
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 상단 정렬
          children: <Widget>[
            SizedBox(height: 10), // 여백 추가
            Image.asset(
              'images/jellyfish.jpg', // 중앙 상단 이미지
              width: 300,
              height: 300,
              fit: BoxFit.cover, // 이미지 크기 조절
            ),
            SizedBox(height: 10),
            TextField(
              controller: urlController, // URL 입력 필드
              decoration: InputDecoration(
                labelText: "Enter API URL",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: fetchPrediction, // 예측 결과 버튼 클릭 시 함수 실행
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("예측결과", style: TextStyle(fontSize: 16)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: fetchProbability, // 예측 확률 버튼 클릭 시 함수 실행
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("예측확률", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              result, // API 응답 결과 표시
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
