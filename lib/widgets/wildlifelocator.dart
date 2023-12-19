import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:google_fonts/google_fonts.dart';

class AI extends StatefulWidget {
  const AI({Key? key}) : super(key: key);



  @override
  State<AI> createState() => _AIState();
}

class _AIState extends State<AI> {
  double fem=1;
  double ffem= 0.9;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Type Location to show Animals found',
              style:  GoogleFonts.poppins (

                fontSize:  22*ffem,
                fontWeight:  FontWeight.w400,
                height:  1.5*ffem/fem,
                color:  Color(0xff6c6c6c),
              ),
            ),
          ),

          Center(
            child: HtmlWidget(
              '<iframe src="https://ora.sh/embed/e3172c9c-165c-4770-b586-ee11cad1df9c" style="height: 500px;"></iframe>',
              factoryBuilder: () => MyWidgetFactory(),
            ),
          ),
        ],
      ),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
