import 'package:first/app/modules/layout/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first/app/data/services/theme_services.dart';
import 'package:get/get.dart';

class HomeAddTask extends StatelessWidget {
  const HomeAddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              )
            ],
          ),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_forward_ios, size: 20, color: primaryClr),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/cat.png"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
