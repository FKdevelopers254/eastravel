import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechPage extends StatefulWidget {
  @override
  _SpeechPageState createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('status: $status');
        },
        onError: (error) {
          print('error: $error');
          _speech.stop();
          setState(() {
            _isListening = false;
          });
        },
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Recognition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text),
            SizedBox(height: 20),
            FloatingActionButton(
              onPressed: _listen,
              child: Icon(_isListening ? Icons.mic : Icons.mic_none),
            ),
          ],
        ),
      ),
    );
  }
}
