import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print("TEST init");
    Timer(Duration(seconds: 4), () {
      Get.toNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashView();
  }
}
