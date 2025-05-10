import 'package:flutter/material.dart';

Future<void> showDeleteDialog(BuildContext context, VoidCallback onDelete) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('대화 기록 삭제'),
      content: const Text('정말 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onDelete();
          },
          child: const Text('삭제', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
