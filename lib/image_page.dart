import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  Future<void> _captureImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return; // User canceled the image capture

      // Handle the captured image, for example, you can display it or upload it.
      if (kDebugMode) {
        print('Image captured: ${image.path}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error capturing image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Home button
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
            // Camera capture icon button
            IconButton(
              icon: const Icon(Icons.camera),
              iconSize: 72.0,
              color: Colors.white,
              onPressed: _captureImage,
            ),
            const SizedBox(height: 20),
            // Text "TAP TO CAPTURE"
            const Text(
              'TAP TO CAPTURE',
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
