import 'package:ethos/screen/homepage.dart';
import 'package:ethos/screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:ethos/screen/news_display.dart';

void main() {
  runApp(const ethos());
}

class ethos extends StatelessWidget {
  const ethos({Key? key}) : super(key: key);
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
