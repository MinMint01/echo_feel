// audio_page.dart

import 'package:flutter/material.dart';
import 'listening_page.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // Home button
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // Navigate back to the home page when the home button is pressed
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Microphone icon button
            IconButton(
              icon: const Icon(Icons.mic),
              iconSize: 72.0,
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListeningPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            // Text "TAP TO SPEAK"
            const Text(
              'TAP TO SPEAK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
