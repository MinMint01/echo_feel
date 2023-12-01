// home_page.dart

import 'package:flutter/material.dart';
import 'audio_page.dart';
import 'image_page.dart';
import 'text_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OptionButton(
              label: 'AUDIO',
              color: const Color(0xFF79E0EE),
              onPressed: () {
                // Navigate to the AudioPage when the "AUDIO" button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AudioPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            OptionButton(
              label: 'IMAGE',
              color: const Color(0xFF98EECC),
              onPressed: () {
                // Navigate to the TextPage when the "IMAGE" button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ImagePage()),
                );
              },
            ),
            const SizedBox(height: 20),
            OptionButton(
              label: 'TEXT',
              color: const Color(0xFFD0F5BE),
              onPressed: () {
                // Navigate to the TextPage when the "TEXT" button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TextPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const OptionButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const StadiumBorder(
          side: BorderSide.none, // Remove the border
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 20, horizontal: 45), // Adjust padding
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.black), // Set text color to black
      ),
    );
  }
}
