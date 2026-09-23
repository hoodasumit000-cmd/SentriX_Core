import 'package:flutter/material.dart';

class AICopilotScreen extends StatefulWidget {
  const AICopilotScreen({super.key});

  @override
  State<AICopilotScreen> createState() => _AICopilotScreenState();
}

class _AICopilotScreenState extends State<AICopilotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'sender': 'ai',
      'text': 'Hello Engineer. SentriX AI Technical Co-Pilot is online. How can I assist with your machine diagnostics today?'
    }
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userQuery = _messageController.text.trim();
    setState(() {
      _messages.add({'sender': 'user', 'text': userQuery});
      _messageController.clear();
    });

    // Simulated AI Response based on SentriX Engine Core
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _messages.add({
          'sender': 'ai',
          'text': 'Analyzing telemetry logs for "$userQuery"... System reports optimal engine RPM and coolant temperature. No critical CAN-Bus fault codes detected.'
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SentriX AI Technical Co-Pilot'),
        backgroundColor: const Color(0xFF1F1F1F),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isUser = _messages[index]['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF00ADB5) : const Color(0xFF252525),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    child: Text(
                      _messages[index]['text']!,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF1F1F1F),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Type diagnostic query or fault code...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF00ADB5)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
