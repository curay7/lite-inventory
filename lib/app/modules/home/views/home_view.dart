import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:first/app/data/services/theme_services.dart';
import 'package:first/app/modules/home/views/home_add_task.dart';
import 'package:first/app/modules/home/views/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/model/task.dart';
import '../../layout/themes.dart';
import '../controllers/home_controller.dart';
import 'package:intl/intl.dart';

import 'widget/task_tile.dart';

final _homeController = Get.find<HomeController>();

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _selectedDate = DateTime.now();
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(_selectedDate),
          const SizedBox(
            height: 17,
          ),
          _showTask()
        ],
      ),
    );
  }

  _showTask() {
    return Expanded(
      child: Obx(
        (() {
          return ListView.builder(
            itemCount: _homeController.taskList.length,
            itemBuilder: ((context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                        child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                  context, _homeController.taskList[index]);
                            },
                            child: TaskTile(_homeController.taskList[index]),
                          ),
                        )
                      ],
                    )),
                  ));
            }),
          );
        }),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 4),
      height: (task.isCompleted == 1)
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? darkGrayClr : Colors.white,
      child: Column(
        children: [
          Container(
            width: 120,
            height: 7,
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          Spacer(),
          (task.isCompleted == 1)
              ? Container()
              : _bottomSheetBotton(
                  label: "Task Completed",
                  onTap: () {
                    _homeController.markCompletedTask(task.id!);
                  },
                  color: primaryClr,
                  context: context),
          _bottomSheetBotton(
              label: "Delete Task",
              onTap: () {
                _homeController.delete(task);
                Get.back();
              },
              color: Colors.red[300],
              context: context),
          SizedBox(
            height: 17,
          ),
          _bottomSheetBotton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              isClose: true,
              color: Colors.red[300],
              context: context),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }

  _bottomSheetBotton(
      {required String label,
      required Function()? onTap,
      required color,
      required BuildContext context,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: isClose == true ? Colors.grey[300] : color,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : color,
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? tileStyle : tileStyle.copyWith(color: Colors.white),
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
          onTap: (() async {
            print("TEST Next Page");
            await Get.to(HomeAddTask());
            _homeController.getTask();
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
