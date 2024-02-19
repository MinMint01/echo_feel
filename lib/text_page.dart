// text_page.dart

import 'package:flutter/material.dart';
import 'message_page.dart'; // Import the message page

class TextPage extends StatefulWidget {
  const TextPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  String _text =
      ''; // Add a variable to store the text entered in the TextField

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
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
                setState(() {
                  _text =
                      value; // Update the _text variable when TextField value changes
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter your text here...',
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15), // Adjust content padding
                fillColor: Colors.grey[900], // Set background color
                filled: true, // Enable background color
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the message page and pass the entered text
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MessagePage(message: _text, image: Null),
                  ),
                );
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
