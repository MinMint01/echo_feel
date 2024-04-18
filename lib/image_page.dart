import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'message_page.dart'; // Import your existing MessagePage

class ProcessingAnimation extends StatelessWidget {
  const ProcessingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            backgroundColor: Colors.black,
          ),
          SizedBox(height: 16),
          Text(
            'Processing the Image...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool _processing = false;

  Future<void> _captureImage(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return;
    }

    setState(() {
      _processing = true;
    });

    var request =
        http.MultipartRequest('POST', Uri.parse("http://192.168.1.4:5000/"));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          json.decode(await response.stream.bytesToString());
      String caption = jsonResponse['caption'];
      caption = caption.substring(2, caption.length - 2);

      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => MessagePage(
            message: caption,
          ),
        ),
      );
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
    }

    setState(() {
      _processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: _processing
            ? const ProcessingAnimation()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera),
                    iconSize: 72.0,
                    color: Colors.white,
                    onPressed: () => _captureImage(context),
                  ),
                  const SizedBox(height: 20),
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
