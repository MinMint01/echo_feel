import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MessagePage(
        message: '',
        image: null,
      ),
    );
  }
}

class MessagePage extends StatelessWidget {
  final String message;

  const MessagePage({super.key, required this.message, required image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Transmitted Message: $message',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            ElevatedButton(
              onPressed: () {
                // Show a snackbar with the message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Message: $message'),
                  ),
                );
              },
              child: const Text('Show Message'),
            ),
          ],
        ),
      ),
    );
  }
}
