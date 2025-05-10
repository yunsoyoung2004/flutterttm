import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/chat_bubble.dart';
import '../models/message_model.dart';

const String baseUrl = 'https://ttmchatbot-2.onrender.com'; // ✅ Render 백엔드 주소

class ChatScreen extends StatefulWidget {
  final String buddyName;
  const ChatScreen({super.key, required this.buddyName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [
    const Message(text: "지금 느끼는 감정을 자세히 말해주시겠어요?", isUser: false)
  ];

  Map<String, dynamic> agentState = {
    "stage": "empathy",
    "question": "",
    "response": "",
    "history": [],
    "turn": 0,
    "intro_shown": false,
    "pending_response": null,
    "awaiting_s_turn_decision": false,
    "awaiting_preparation_decision": false,
    "retry_count": 0
  };

  bool _isStreaming = false;
  String _currentStreamingText = "";

  Future<void> _sendMessageStream(String text) async {
    if (text.trim().isEmpty || _isStreaming) return;

    setState(() {
      _messages.add(Message(text: text, isUser: true));
      _isStreaming = true;
      _currentStreamingText = "";
      _messages.add(const Message(text: "", isUser: false));
    });

    agentState["question"] = text;

    final request = http.Request(
      'POST',
      Uri.parse('$baseUrl/chat/stream'), // ✅ 정확한 엔드포인트
    );
    request.headers.addAll({'Content-Type': 'application/json'});
    request.body = jsonEncode({"state": agentState});

    try {
      final response = await request.send();

      response.stream.transform(utf8.decoder).listen(
            (chunk) {
          if (chunk.contains("---END_STAGE---")) {
            final parts = chunk.split("---END_STAGE---");
            final textPart = parts[0].trim();
            final jsonPart = parts.length > 1 ? parts[1].trim() : "";

            if (textPart.isNotEmpty) {
              if (_messages.isEmpty || _messages.last.text != textPart) {
                _currentStreamingText += textPart;
                _updateLastAssistantMessage(_currentStreamingText.trim());
              }
            }

            try {
              final next = jsonDecode(jsonPart);
              if (next.containsKey("next_stage")) {
                agentState["stage"] = next["next_stage"];
              }
              if (next.containsKey("turn")) {
                agentState["turn"] = next["turn"];
              }
              if (next.containsKey("response")) {
                agentState["response"] = next["response"];
              }
              if (next.containsKey("history")) {
                agentState["history"] = next["history"];
              }
              if (next.containsKey("intro_shown")) {
                agentState["intro_shown"] = next["intro_shown"];
              }
            } catch (e) {
              print("⚠️ 상태 JSON 파싱 오류: $e");
            }

            return;
          }

          _currentStreamingText += chunk;
          _updateLastAssistantMessage(_currentStreamingText.trim());
        },
        onError: (e) {
          setState(() {
            _isStreaming = false;
            _messages.add(const Message(text: "⚠️ 스트림 오류 발생", isUser: false));
          });
        },
        onDone: () {
          setState(() {
            _isStreaming = false;
            _controller.clear();
          });
        },
        cancelOnError: true,
      );
    } catch (e) {
      setState(() {
        _isStreaming = false;
        _messages.add(const Message(text: "⚠️ 서버 연결 실패", isUser: false));
      });
    }
  }

  void _updateLastAssistantMessage(String text) {
    setState(() {
      if (_messages.isNotEmpty && !_messages.last.isUser) {
        _messages.removeLast();
      }
      _messages.add(Message(text: text, isUser: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("${widget.buddyName}와의 메시지",
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) => ChatBubble(
                message: _messages[index],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: "응답을 입력하세요..",
                            border: InputBorder.none,
                          ),
                          onSubmitted: _sendMessageStream,
                          enabled: !_isStreaming,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF6A4DFF),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () => _sendMessageStream(_controller.text),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

