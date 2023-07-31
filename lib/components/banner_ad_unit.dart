import 'dart:html' as html;  
import 'dart:ui' as ui;  
  
import 'package:flutter/material.dart';  
  
String viewID = "8006810190";  
  
class BannerAdUnit extends StatelessWidget {  
  const BannerAdUnit({Key? key}) : super(key: key);  
  
  @override  
  Widget build(BuildContext context) {  
  ui.platformViewRegistry.registerViewFactory(  
  viewID,  
  (int id) => html.IFrameElement()  
  ..style.width = '100%'  
  ..style.height = '100%'  
  ..srcdoc = '''<!DOCTYPE html>  
 <html> <head> </head> <body>             
                     
 <script async src="https://cdn.ampproject.org/v0/amp-ad-0.1.js"></script>    
 
 <amp-ad width="100vw" height="320"
     type="adsense"
     data-ad-client="ca-pub-9154794803302860"
     data-ad-slot="8006810190"
     data-auto-format="rspv"
     data-full-width="">
  <div overflow=""></div>
</amp-ad>
        </body>  
 </html>'''  
  ..style.border = 'none');  
  
  return SizedBox(  
  height:100,  
  width: double.infinity,  
  child: HtmlElementView(  
  viewType: viewID,  
  ),  
  );  
  }  
}