import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../activity_indicator.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
class LearnSwahili extends StatefulWidget {
  @override
  State<LearnSwahili> createState() => _LearnSwahiliState();
}

class _LearnSwahiliState extends State<LearnSwahili> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';

  bool isSourceModelDownloaded = false;
  bool isTargetModelDownloaded = false;

  final FlutterTts flutterTts = FlutterTts();





  String? _translatedText;
  final _controller = TextEditingController();
  final _modelManager = OnDeviceTranslatorModelManager();



  final List<TranslateLanguage> _sourceLanguage = [

    TranslateLanguage.polish,
    TranslateLanguage.french,
    TranslateLanguage.spanish,
    TranslateLanguage.dutch,
    TranslateLanguage.italian,
    // add more languages here
  ];





  final _targetLanguage = TranslateLanguage.swahili;
  late TranslateLanguage _selectedTargetLanguage = _sourceLanguage[0];

  late final _onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: _selectedTargetLanguage,
    targetLanguage: _targetLanguage,
  );




  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    bool available = await _speech.initialize(
      onError: (error) {
        print('Error: $error');
        // Handle initialization error here
      },
    );

    if (available) {
      setState(() {
        // Set up speech recognition
      });
    } else {
      print('Speech recognition not available');
      // Handle unavailability of speech recognition
    }
  }


  Future<void> _listen() async {
    if (!_isListening) {
      bool listening = await _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
            _controller.text = _text; // Update the text field with recognized words
          });
        },
      );
      if (listening) {
        setState(() {
          _isListening = true;
        });
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }


  @override
  void dispose() {
    _onDeviceTranslator.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _modelManager.isModelDownloaded(_selectedTargetLanguage.bcpCode).then((isDownloaded) {
      setState(() {
        isSourceModelDownloaded = isDownloaded;
      });
    });


    _modelManager.isModelDownloaded(_targetLanguage.bcpCode).then((isDownloaded) {
      setState(() {
        isTargetModelDownloaded = isDownloaded;
      });
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Translator',style: GoogleFonts.andika(fontWeight: FontWeight.w600,letterSpacing: 2.0,fontSize:20),),
          actions: [
            DropdownButton<TranslateLanguage>(
              value: _selectedTargetLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedTargetLanguage = value!;
                  _translateText();
                });
              },
              items: _sourceLanguage.map<DropdownMenuItem<TranslateLanguage>>(
                      (lang) => DropdownMenuItem<TranslateLanguage>(
                    value: lang,
                    child: Text(lang.name),
                  )
              ).toList(),
            )

          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(height: 30),
              Center(
                  child: Text('Enter text (in ${_selectedTargetLanguage.name} )',style:GoogleFonts.andika() ),),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your text here',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                  ),
                ),
              ),




             
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                MaterialButton(
              onPressed:_translateText,
                  child: const Row(
                    children: [
                      Text('Translate'),

                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    await flutterTts.setLanguage(_targetLanguage.bcpCode);
                    await flutterTts.speak(_translatedText ?? '');
                  },
                  child: Row(
                    children: [
                      Text('Speak'),

                    ],
                  ),
                ),
                MaterialButton(
                  onPressed:_listen,
                  child: Row(
                    children: [
                      _isListening ?
                      Text('Listen') : Text('Lis') ,

                    ],
                  ),
                ),

              //  IconButton(onPressed: () async {await flutterTts.setLanguage(_targetLanguage.bcpCode);await flutterTts.speak(_translatedText ?? '');}, icon: Icon(Icons.mic),),
             //   IconButton(onPressed: (){}, tooltip:'Listen', icon: Icon(Icons.speaker),),
            //    IconButton(onPressed: _listen, icon: Icon(_isListening ? Icons.mic : Icons.mic_none),),
              ]),
              const SizedBox(height: 30),

              Center(
                child: Text(
                  'Translated Text (${_targetLanguage.name})',
               style:GoogleFonts.andika() ),
              ),



              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                    ),
                  ),
                  child: Text(
                    _translatedText ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),





              SizedBox(height: 20),





              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  isSourceModelDownloaded ?
                  Container() : ElevatedButton(
                    onPressed: _isSourceModelDownloaded,
                    child: Text(
                      'Download Source', style: TextStyle(color:  Colors.red),),),
                  isSourceModelDownloaded ? Text('') : ElevatedButton(
                      onPressed: _downloadSourceModel,
                      child: const Text('Download Source Model')),






                ],
              ),
              Row(
                children: [

                  ElevatedButton(
                    onPressed: _isTargetModelDownloaded,
                    child: Text(
                      'Target Download Target', style: TextStyle(color: isTargetModelDownloaded ? Colors.green : Colors.red),),),

                  isTargetModelDownloaded ? Text('') : ElevatedButton(
                      onPressed: _downloadTargetModel,
                      child: const Text('Download Target Model')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _downloadSourceModel() async {
    Toast().show(
        'Downloading model (${_selectedTargetLanguage.name})...',
        _modelManager
            .downloadModel(_selectedTargetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _downloadTargetModel() async {
    Toast().show(
        'Downloading model (${_targetLanguage.name})...',
        _modelManager
            .downloadModel(_targetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _deleteSourceModel() async {
    Toast().show(
        'Deleting model (${_selectedTargetLanguage.name})...',
        _modelManager
            .deleteModel(_selectedTargetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _deleteTargetModel() async {
    Toast().show(
        'Deleting model (${_targetLanguage.name})...',
        _modelManager
            .deleteModel(_targetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _isSourceModelDownloaded() async {
    Toast().show(
        'Checking if model (${_selectedTargetLanguage.name}) is downloaded...',
        _modelManager
            .isModelDownloaded(_selectedTargetLanguage.bcpCode)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _isTargetModelDownloaded() async {
    Toast().show(
        'Checking if model (${_selectedTargetLanguage.name}) is downloaded...',
        _modelManager
            .isModelDownloaded(_selectedTargetLanguage.bcpCode)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _translateText() async {
    FocusScope.of(context).unfocus();
    final result = await _onDeviceTranslator.translateText(_controller.text);
    setState(() {
      _translatedText = result;
    });
  }




}