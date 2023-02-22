import 'package:news_app/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screen/news_display.dart';
import 'constants/AppColors.dart';
import 'package:news_app/screen/news_display.dart';
import 'util/appbar.dart';
import 'package:news_app/screen/homepage.dart';

void main() {
  runApp(const Ethos());
}

class Ethos extends StatelessWidget {
  const Ethos({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var routes = {
      '/': (context) => homepage(),
   
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}
