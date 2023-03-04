import 'package:flutter/material.dart';
import 'package:ethos/constants/AppColors.dart';

class Appbar {
  static AppBar getAppBar(String title) {
    return AppBar(
      // leading: Icon(Icons.back_hand),
      automaticallyImplyLeading: false,
      shadowColor: AppColors.black,
      backgroundColor: AppColors.black,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'RobotoSlab',
            fontWeight: FontWeight.bold,
            letterSpacing: 3.5,
            fontSize: 29.0),
      ),
    );
  }
}
