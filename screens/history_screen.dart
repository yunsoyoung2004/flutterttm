import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = List.generate(5, (index) => '그 생각을 하고 있다는 게 시작이야. 지금은 조금씩 좋아지고 있어...');

    return Scaffold(
      appBar: AppBar(title: const Text('대화 기록')),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(history[index]),
          subtitle: const Text("08 August 2024 | 03:23 AM"),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDeleteDialog(context),
        child: const Icon(Icons.delete_forever),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('대화 기록 모두 삭제'),
        content: const Text('대화 기록을 모두 삭제하시겠습니까? 삭제 후에는 복구할 수 없습니다.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('삭제', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
