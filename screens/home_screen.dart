import 'package:flutter/material.dart';
import 'friend_list_screen.dart';
import 'history_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF6A4DFF),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: '친구 목록'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: '대화 기록'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const FriendListScreen()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "안녕하세요 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pretendard',
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "오늘 기분은 어떠신가요?\n오늘도 즐거운 대화를 시작해봐요!",
              style: TextStyle(fontSize: 16, fontFamily: 'Pretendard'),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF6A4DFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("새로운 대화하기",
                      style: TextStyle(color: Colors.white70, fontSize: 14, fontFamily: 'Pretendard')),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(child: Text("?"), backgroundColor: Colors.white),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Joyce", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              Text("2 Min", style: TextStyle(color: Colors.white60, fontSize: 12))
                            ],
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ChatScreen(buddyName: 'Joyce')),
                          );
                        },
                        child: const Text("버디에게 새 메시지 보내기",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text("최근 대화 계속하기", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 14),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: CircleAvatar(child: Text('J')), title: Text('Joyce'), subtitle: Text('Budddy - 2d ago'),
                  ),
                  ListTile(
                    leading: CircleAvatar(child: Text('E')), title: Text('Ellie'), subtitle: Text('Budddy - 2d ago'),
                  ),
                  ListTile(
                    leading: CircleAvatar(child: Text('J')), title: Text('Joyce'), subtitle: Text('Budddy - 2d ago'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
