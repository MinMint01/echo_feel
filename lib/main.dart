import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'audio_page.dart';
import 'text_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'lib\\assets\\welcome_page.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Text with Animation
          SlideTransition(
            position: _offsetAnimation,
            child: const Center(
              child: Text(
                'Welcome to EchoFeel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Arrow Button
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              onPressed: () {
                // Navigate to the home page (HomePage) here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// home_page.dart

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
                if (kDebugMode) {
                  print('Image option selected');
                }
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
      ),
      child: Text(label),
    );
  }
}
