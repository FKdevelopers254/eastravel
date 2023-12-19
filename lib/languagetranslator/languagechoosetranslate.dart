import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import 'activity_indicator.dart';

class LanguageTranslatorVieww extends StatefulWidget {
  @override
  State<LanguageTranslatorVieww> createState() => _LanguageTranslatorViewwState();
}

class _LanguageTranslatorViewwState extends State<LanguageTranslatorVieww> {




  String? _translatedText;
  final _controller = TextEditingController();
  final _modelManager = OnDeviceTranslatorModelManager();



  final List<TranslateLanguage> _targetLanguages = [
    TranslateLanguage.polish,
    TranslateLanguage.french,
    TranslateLanguage.spanish,
    TranslateLanguage.dutch,
    TranslateLanguage.italian,
    // add more languages here
  ];




  final _sourceLanguage = TranslateLanguage.english;
  //final _targetLanguage = TranslateLanguage.polish;
  late TranslateLanguage _selectedTargetLanguage = _targetLanguages[0];

  late final _onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: _sourceLanguage,
    targetLanguage: _selectedTargetLanguage,
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
          title: const Text('On-device Translation'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(height: 30),
              Center(
                  child: Text('Enter text (source: ${_sourceLanguage.name})')),
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
                  'Translated Text (target: ${_selectedTargetLanguage.name})',
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
                items: _targetLanguages.map<DropdownMenuItem<TranslateLanguage>>((lang) {
                  return DropdownMenuItem<TranslateLanguage>(
                    value: lang,
                    child: Text(lang.name),
                  );
                }).toList(),
              ),

              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                        )),
                    child: Text(_translatedText ?? '')),
              ),
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: _translateText, child: Text('Translate'))
              ]),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: _downloadSourceModel,
                      child: Text('Download Source Model')),
                  ElevatedButton(
                      onPressed: _downloadTargetModel,
                      child: Text('Download Target Model')),
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
                      child: Text('Source Downloaded?')),
                  ElevatedButton(
                      onPressed: _isTargetModelDownloaded,
                      child: Text('Target Downloaded?')),
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
        'Downloading model (${_sourceLanguage.name})...',
        _modelManager
            .downloadModel(_sourceLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _downloadTargetModel() async {
    Toast().show(
        'Downloading model (${_selectedTargetLanguage.name})...',
        _modelManager
            .downloadModel(_selectedTargetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _deleteSourceModel() async {
    Toast().show(
        'Deleting model (${_sourceLanguage.name})...',
        _modelManager
            .deleteModel(_sourceLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _deleteTargetModel() async {
    Toast().show(
        'Deleting model (${_selectedTargetLanguage.name})...',
        _modelManager
            .deleteModel(_selectedTargetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _isSourceModelDownloaded() async {
    Toast().show(
        'Checking if model (${_sourceLanguage.name}) is downloaded...',
        _modelManager
            .isModelDownloaded(_sourceLanguage.bcpCode)
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