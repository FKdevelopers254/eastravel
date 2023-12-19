import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import '../activity_indicator.dart';
import 'package:flutter_tts/flutter_tts.dart';


class LanguageTeacher extends StatefulWidget {
  @override
  State<LanguageTeacher> createState() => _LanguageTeacherState();
}

class _LanguageTeacherState extends State<LanguageTeacher> {

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
  void dispose() {
    _onDeviceTranslator.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Language Teacher'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(height: 30),
              Center(
                  child: Text('Enter text (source: ${_selectedTargetLanguage.name} )')),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                      )),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(border: InputBorder.none),
                    maxLines: null,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Translated Text (target: ${_targetLanguage.name})',
                ),
              ),
              SizedBox(height: 30),
              DropdownButton<TranslateLanguage>(
                value: _selectedTargetLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedTargetLanguage = value!;
                    _translateText();
                  });
                },
                items: _sourceLanguage.map<DropdownMenuItem<TranslateLanguage>>((lang) {
                  return DropdownMenuItem<TranslateLanguage>(
                    value: lang,
                    child: Text(lang.name),
                  );
                }).toList(),
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
                        )),
                    child: Text(_translatedText ?? '')),
              ),



              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: _translateText, child: const Text('Translate')),

                IconButton(

                  onPressed: () async {
                    await flutterTts.setLanguage(_targetLanguage.bcpCode);
                    await flutterTts.speak(_translatedText ?? '');
                  },
                  icon: Icon(Icons.speaker),
                ),
              ]),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: _downloadSourceModel,
                      child: const Text('Download Source Model')),
                  ElevatedButton(
                      onPressed: _downloadTargetModel,
                      child: const Text('Download Target Model')),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: _deleteSourceModel,
                      child: Text('Delete Source Model')),
                  ElevatedButton(
                      onPressed: _deleteTargetModel,
                      child: Text('Delete Target Model')),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: _isSourceModelDownloaded,
                      child: const Text('Source Downloaded?')),
                  ElevatedButton(
                      onPressed: _isTargetModelDownloaded,
                      child: const Text('Target Downloaded?')),
                ],
              ),
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