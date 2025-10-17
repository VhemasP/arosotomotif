import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';
import 'providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatAdminPageState();
}

class _ChatAdminPageState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  void _sendMessage(ChatProvider chatProvider, User user) {
    final sender = user.isAdmin ? 'Admin' : 'User';
    chatProvider.sendMessage(_controller.text, sender);
    _controller.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final user = Provider.of<User>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Bantuan'),
        backgroundColor: user.isAdmin ? Colors.indigo.shade700 : Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: chatProvider.messages.length,
              itemBuilder: (ctx, i) {
                final message = chatProvider.messages[i];
                final isMe = (user.isAdmin && message.sender == 'Admin') ||
                    (!user.isAdmin && message.sender == 'User');

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue.shade100 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(message.text),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(chatProvider, user),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue.shade700),
                  onPressed: () => _sendMessage(chatProvider, user),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}