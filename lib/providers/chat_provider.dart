import 'package:flutter/material.dart';

class ChatMessage {
  final String sender;
  final String text;
  final DateTime timestamp;

  ChatMessage({required this.sender, required this.text, required this.timestamp});
}

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(
      sender: 'Admin',
      text: 'Selamat datang! Ada yang bisa kami bantu?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  List<ChatMessage> get messages => _messages;

  void sendMessage(String text, String sender) {
    if (text.trim().isEmpty) return;

    final message = ChatMessage(sender: sender, text: text, timestamp: DateTime.now());
    _messages.add(message);
    notifyListeners();

    if (sender == 'User') {
      Future.delayed(const Duration(seconds: 2), () {
        final reply = ChatMessage(
          sender: 'Admin',
          text: 'Baik, pesan Anda sudah kami terima. Mohon tunggu balasan dari tim kami.',
          timestamp: DateTime.now(),
        );
        _messages.add(reply);
        notifyListeners();
      });
    }
  }
}