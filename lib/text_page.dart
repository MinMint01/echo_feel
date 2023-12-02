// text_page.dart

import 'package:flutter/material.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {});
              },
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter your text here...',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Send message logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF98EECC),
              ),
              child: const Text(
                'Send Message',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
