import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'message_page.dart';

class ListeningPage extends StatefulWidget {
  const ListeningPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListeningPageState createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _audioController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Start listening when the page is loaded
    _startListening();
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioController.dispose();
    super.dispose();
  }

  Future<void> _startListening() async {
    if (await _speech.initialize()) {
      setState(() {
        _isListening = true;
      });
      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
          if (result.finalResult) {
            // Do not stop listening here, continue listening in the background
            // _stopListening();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessagePage(message: _text),
              ),
            );
          }
        },
      );
    } else {
      if (kDebugMode) {
        print('Speech recognition not available');
      }
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Listening text
            const Text(
              'Listening',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Wave animation
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Dot(animationValue: _animation.value),
                    Dot(animationValue: _animation.value - 0.2),
                    Dot(animationValue: _animation.value - 0.4),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            // STOP button
            ElevatedButton(
              onPressed: _isListening ? _stopListening : null,
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFF98EECC)),
              child: const Text('STOP'),
            ),
          ],
        ),
      ),
    );
  }
}

// Define the Dot class
class Dot extends StatelessWidget {
  final double animationValue;

  const Dot({super.key, required this.animationValue});

  @override
  Widget build(BuildContext context) {
    double opacity = 0.7 - animationValue;
    opacity = opacity.clamp(0.0, 1.0); // Ensure opacity is within valid bounds

    return Container(
      margin: const EdgeInsets.all(5.0),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(opacity),
      ),
    );
  }
}
