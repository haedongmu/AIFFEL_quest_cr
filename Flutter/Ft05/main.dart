import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "";
  TextEditingController urlController = TextEditingController(); // URL 입력 컨트롤러

  Future<void> fetchPrediction() async {
    await fetchData("sample");
  }

  Future<void> fetchProbability() async {
    await fetchData("probability");
  }

  Future<void> fetchData(String endpoint) async {
    try {
      final enteredUrl = urlController.text;
      final response = await http.get(
        Uri.parse(enteredUrl + 'sample'),
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Parsed Data: $data");
        setState(() {
          result = endpoint == "sample"
              ? "Predicted Label: ${data['predicted_label']}"
              : "Prediction Probability: ${data['prediction_score'].toString()}";
        });
      } else {
        setState(() {
          result = "Failed to fetch data. Status Code: ${response.statusCode}";
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset('images/jellyfish_icon.png'), // 앱바 왼쪽에 이미지 추가
        ),
        title: Center(
          child: Text(
            "Jellyfish Classifier",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true, // 중앙 정렬 적용
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 위쪽 정렬
          children: <Widget>[
            SizedBox(height: 10), // 상단 여백 줄임
            Image.asset(
              'images/jellyfish.jpg', // 중앙 상단에 추가할 이미지 공간
              width: 300,
              height: 300,
              fit: BoxFit.cover, // 또는 BoxFit.contain
            ),
            SizedBox(height: 10), // 이미지 아래 여백 줄임
            TextField(
              controller: urlController,
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
                  onPressed: fetchPrediction,
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
                  onPressed: fetchProbability,
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
              result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
