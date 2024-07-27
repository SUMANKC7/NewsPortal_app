import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/homescreen.dart';

void main() {

  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily:GoogleFonts.poppins().fontFamily ),
      home:Homescreen(),
    );
  }
}
