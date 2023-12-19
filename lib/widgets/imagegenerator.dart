import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class ImageGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Generator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ImageGeneratorScreen(),
    );
  }
}

class ImageGeneratorScreen extends StatefulWidget {
  @override
  _ImageGeneratorScreenState createState() => _ImageGeneratorScreenState();
}

class _ImageGeneratorScreenState extends State<ImageGeneratorScreen> {
  String generatedImage = '';
  String userInput = '';
  bool isLoading = false;
  String selectedModel = 'image-alpha-001';

  void generateImageFromText(String text) async {
    setState(() {
      isLoading = true;
    });

    String apiKey = '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'; // Replace with your OpenAI API key
    String apiUrl = 'https://api.openai.com/v1/completions';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': selectedModel,
        'prompt': text,
        'max_tokens': 50,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        generatedImage = data['choices'][0]['text'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedModel,
              onChanged: (String? newValue) {
                setState(() {
                  selectedModel = newValue!;
                });
              },
              items: <String>[
                'image-alpha-001',
                'image-alpha-002',
                'image-alpha-003',
                // Add more model options here as needed
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (text) {
                setState(() {
                  userInput = text;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter text to generate image',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => generateImageFromText(userInput),
              child: Text('Generate Image'),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : generatedImage.isNotEmpty
                ? Image.network(generatedImage)
                : Text('Generated image will appear here'),
          ],
        ),
      ),
    );
  }
}
