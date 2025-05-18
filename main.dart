import 'package:flutter/material.dart';
import 'screens/chat_screen.dart'; // ✅ ChatScreen을 import하세요

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TTM Chatbot',
      debugShowCheckedModeBanner: false,
      home: const ChatScreen(buddyName: "소영봇"), // ✅ 바로 ChatScreen으로 진입
    );
  }
}
