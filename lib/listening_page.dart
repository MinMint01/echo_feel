import 'package:flutter/material.dart';

class ListeningPage extends StatefulWidget {
  const ListeningPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListeningPageState createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _audioController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioController.dispose();
    super.dispose();
  }

  void _stopAudio() {
    // Add any necessary logic to stop the audio playback
    // For example, you can use a package like audioplayers
    // and call stop method on the player instance.
    // audioPlayer.stop();

    // Navigate to the home page
    Navigator.of(context).pop();
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
            // Textbox for speaking audio
            Container(
              width: 200,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _audioController,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // STOP button
            ElevatedButton(
              onPressed: _stopAudio,
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

class Dot extends StatelessWidget {
  final double animationValue;

  const Dot({Key? key, required this.animationValue}) : super(key: key);

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
