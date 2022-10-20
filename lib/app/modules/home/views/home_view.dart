import 'package:first/app/data/services/notification_services.dart';
import 'package:first/app/data/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

final _homeController = Get.find<HomeController>();

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
          _homeController.sendNotification('Theme Change',
              Get.isDarkMode ? "Activated Light Mode" : "Activated Dark Mode");
        },
        child: const Icon(
          Icons.nightlight_round,
          size: 20,
        ),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      actions: [
        const Icon(Icons.person),
        // ignore: prefer_const_constructors
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
