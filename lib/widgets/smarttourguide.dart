import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:google_fonts/google_fonts.dart';

class SmartAI extends StatefulWidget {
  const SmartAI({Key? key}) : super(key: key);



  @override
  State<SmartAI> createState() => _SmartAIState();
}

class _SmartAIState extends State<SmartAI> {
  double fem=1;
  double ffem= 0.9;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Ask Anything About Kenya',
                style:  GoogleFonts.poppins (

                  fontSize:  25*ffem,
                  fontWeight:  FontWeight.w400,
                  height:  1.5*ffem/fem,
                  color:  Color(0xff6c6c6c),
                ),
              ),
            ),

            Center(
              child: HtmlWidget(
                '<iframe src="https://ora.sh/embed/2a74cc1a-9ec1-4963-8fcb-8abe15c523ac" style="height: 500px;"></iframe>',
                factoryBuilder: () => MyWidgetFactory(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
