import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login/views/login_view.dart';
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
      Get.to(LoginView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashView();
  }
}
