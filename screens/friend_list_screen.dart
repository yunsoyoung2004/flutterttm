import 'package:flutter/material.dart';
import '../widgets/buddy_card.dart';
import 'chat_screen.dart';

class FriendListScreen extends StatelessWidget {
  const FriendListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buddies = [
      {'name': 'Joyce', 'desc': '나는 너에게 전적으로 지지할게.'},
      {'name': 'Luna', 'desc': '술을 많이 마시면 최악의 경우…'},
      {'name': 'Solace', 'desc': '고요한 위로를 드릴게요.'},
      {'name': 'Lex', 'desc': '강하게 밀어붙이는 스타일!'},
      {'name': 'Ellie', 'desc': '부드럽고 따뜻한 조언자'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('친구 목록')),
      body: ListView.builder(
        itemCount: buddies.length,
        itemBuilder: (context, index) => BuddyCard(
          name: buddies[index]['name']!,
          description: buddies[index]['desc']!,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(buddyName: buddies[index]['name']!),
            ),
          ),
        ),
      ),
    );
  }
}