import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'package:tflite_v2/tflite_v2.dart';

class CatDogClassifier extends StatefulWidget {


  @override
  _CatDogClassifierState createState() => _CatDogClassifierState();
}

class _CatDogClassifierState extends State<CatDogClassifier> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _output = output!;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/models/model_unquant.tflite',
      labels: 'assets/models/labels.txt',
    );
  }



  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {});
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
       // backgroundColor: Colors.black87,
       // appBar: AppBar(elevation: 2, backgroundColor: Colors.deepOrangeAccent, title: Text('Cat and Dog Classifier', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),), iconTheme: IconThemeData(color: Colors.white), centerTitle: false, automaticallyImplyLeading: true,),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            //gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.004, 1], colors: [Color(0xFF000000), Color(0xFF3d3d3d),],),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'Birdy App',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      //fontWeight: FontWeight.w500,
                      fontSize: 28),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: _loading
                    ? Container(
                  width: 250,
                  child: Column(
                    children: <Widget>[
                      Text('Choose Image or take Image',style: GoogleFonts.poppins(
                          color: Colors.black,
                          //fontWeight: FontWeight.w500,
                         // fontSize: 28
                      )),
                      Lottie.asset('assets/icons/birdy.json'),


                      SizedBox(height: 10),

                      Text('Welcome to our Smart bird app!Perfect for birdwatchers, researchers, and nature lovers. Start exploring the wonderful world of birds!',style: GoogleFonts.poppins(  fontSize: 19),),
                    ],
                  ),
                )
                    : Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 250,
                          child: Image.file(_image),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _output != null
                            ? Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Text('It\'s ${_output[0]['label']}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20.0)),
                              Text('It\'s ${(_output[0]['confidence'] * 100.0).toStringAsFixed(2)}%' ,
                                  style: TextStyle(
                                    color: _output[0]['confidence'] <= 0.2
                                        ? Colors.red
                                        : _output[0]['confidence'] <= 0.4
                                        ? Colors.orange
                                        : _output[0]['confidence'] <= 0.6
                                        ? Colors.lightGreen[300]
                                        : Colors.green,
                                      )),







                            ],
                          ),
                        )
                            : Container(),
                      ],
                    )),
              ),

            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget> [
            FloatingActionButton(onPressed: pickImage, child: const Icon(Icons.camera_alt_outlined),),
            const SizedBox(height: 20,),
            FloatingActionButton(onPressed: pickGalleryImage, child: const Icon(Icons.browse_gallery_outlined),),

          ],
        ),
      ),
    );
  }
}





