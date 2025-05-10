// 📁 lib/models/message_model.dart

class Message {
  final String text;
  final bool isUser;

  const Message({
    required this.text,
    required this.isUser,
  });

  // ✅ JSON 변환 (필요 시 확장 가능)
  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "isUser": isUser,
    };
  }

  // ✅ 텍스트 리스트만 추출 → FastAPI의 history 필드에 사용
  static List<String> extractTexts(List<Message> messages) {
    return messages.map((m) => m.text).toList();
  }

  // ✅ 메시지 생성 from 서버 응답 (optionally 사용)
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'] ?? '',
      isUser: json['isUser'] ?? false,
    );
  }
}
