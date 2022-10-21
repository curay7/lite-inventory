import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:first/app/data/services/theme_services.dart';
import 'package:first/app/modules/home/views/home_add_task.dart';
import 'package:first/app/modules/home/views/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../layout/themes.dart';
import '../controllers/home_controller.dart';
import 'package:intl/intl.dart';

final _homeController = Get.find<HomeController>();

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _selectedDate = DateTime.now();
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(_selectedDate),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
          _homeController.sendNotification('Theme Change',
              Get.isDarkMode ? "Activated Light Mode" : "Activated Dark Mode");
        },
        child: Icon(CupertinoIcons.moon_stars,
            size: 20, color: Color.fromARGB(255, 110, 108, 108)),
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

  _addTaskBar() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.yMMMMd().format(DateTime.now()),
                      style: subHeadingStyle),
                  Text("Today", style: headingStyle)
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        homeBtn(
          label: "+ Add Task",
          onTap: (() {
            print("TEST Next Page");
            Get.to(HomeAddTask());
          }),
        )
      ],
    );
  }

  _addDateBar(selectedDate) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          _addDateBar(selectedDate);
        },
      ),
    );
  }
}
