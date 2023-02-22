import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/screen/homepage.dart';
import '../constants/AppColors.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
              "https://assets2.lottiefiles.com/packages/lf20_ex5DR6Osfr.json",
              controller: _controller, onLoaded: (compos) {
            _controller
              ..duration = compos.duration
              ..forward().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => homepage()));
              });
          }),
          const Center(
              child: Text(
            "Welcome To EthoX",
            style: TextStyle(
              color: AppColors.white,
              fontFamily: "RobotoSlab",
              fontSize: 20,
              // fontWeight: FontWeight.bold
            ),
          )),
        ],
      ),
    );
  }
}
