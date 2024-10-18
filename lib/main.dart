import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pronunciation App',
      home: PronunciationScreen(),
    );
  }
}

class PronunciationScreen extends StatefulWidget {
  const PronunciationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PronunciationScreenState createState() => _PronunciationScreenState();
}

class _PronunciationScreenState extends State<PronunciationScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final GoogleTranslator translator = GoogleTranslator();
  final TextEditingController textController = TextEditingController();
  double _speechRate = 0.5;

  Future<void> _speak(String text, String language) async {
    await flutterTts.setLanguage(language);
    await flutterTts.setSpeechRate(_speechRate);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pronunciation App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Text',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String text = textController.text;
                if (text.isNotEmpty) {
                  _speak(text, 'en-US');
                }
              },
              child: const Text('Pronounce in English'),
            ),
            const SizedBox(height: 20),
            
            const SizedBox(height: 20),
            Text('Speech Rate: ${_speechRate.toStringAsFixed(1)}'),
            Slider(
              value: _speechRate,
              min: 0.1,
              max: 1.0,
              onChanged: (newRate) {
                setState(() {
                  _speechRate = newRate;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
