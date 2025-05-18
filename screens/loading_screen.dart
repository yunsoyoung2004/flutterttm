import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'chat_screen.dart';

// ✅ 실제 배포된 Render 백엔드 주소로 교체하세요
const String baseUrl = 'https://ttmchatbot-737295793059.asia-northeast3.run.app';

class LoadingScreen extends StatefulWidget {
  final String buddyName;
  const LoadingScreen({super.key, required this.buddyName});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _waitForModelReady();
  }

  Future<void> _waitForModelReady() async {
    while (true) {
      try {
        final response = await http.get(Uri.parse('$baseUrl/status'));
        final data = jsonDecode(response.body);

        if (data['ready'] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(buddyName: widget.buddyName),
            ),
          );
          return;
        }
      } catch (e) {
        setState(() => _error = true);
        await Future.delayed(const Duration(seconds: 2));
      }

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      body: Center(
        child: _error
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.error, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Text(
              "서버 연결 실패\n잠시 후 다시 시도 중...",
              textAlign: TextAlign.center,
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("챗봇 모델을 준비 중입니다...", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TTM Chatbot',
      home: const LoadingScreen(buddyName: "소영봇"),
      debugShowCheckedModeBanner: false,
    );
  }
}

