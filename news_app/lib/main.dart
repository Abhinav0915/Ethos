import 'package:news_app/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screen/splash.dart';

void main() {
  runApp(const Ethos());
}

class Ethos extends StatelessWidget {
  const Ethos({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var routes = {
      '/': (context) => homepage(),
      '/splash': (context) => splash(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
      ),
      initialRoute: '/splash',
      routes: routes,
    );
  }
}
