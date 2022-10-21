import 'package:first/app/data/model/task.dart';
import 'package:first/app/modules/home/views/widget/button.dart';
import 'package:first/app/modules/home/views/widget/input_field.dart';
import 'package:first/app/modules/layout/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeAddTask extends StatefulWidget {
  const HomeAddTask({Key? key}) : super(key: key);

  @override
  State<HomeAddTask> createState() => _HomeAddTaskState();
}

class _HomeAddTaskState extends State<HomeAddTask> {
  final HomeController homeTaskController = Get.put(HomeController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _selectedStartTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectedEndTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();

  int _selectedReminder = 7;
  List<int> reminderList = [1, 2, 3, 4, 5, 6, 7];

  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

  int _selectedColor = 0;
  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    1,
    2,
    3,
    4,
    5,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              CustomInputForm(
                title: "Title",
                hint: 'Enter Title Here',
                controller: _titleController,
              ),
              CustomInputForm(
                title: "Note",
                hint: 'Enter Note Here',
                controller: _noteController,
              ),
              CustomInputForm(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInputForm(
                      title: "Start Time",
                      hint: _selectedStartTime,
                      widget: IconButton(
                        icon: const Icon(Icons.access_time_rounded),
                        onPressed: () {
                          _getTimeFromUser(isStartedTime: true);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: CustomInputForm(
                      title: "End Time",
                      hint: _selectedEndTime,
                      widget: IconButton(
                        icon: const Icon(Icons.access_time_rounded),
                        onPressed: () {
                          _getTimeFromUser(isStartedTime: false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              CustomInputForm(
                title: "Remind",
                hint: "$_selectedReminder Minutes early",
                widget: DropdownButton<int>(
                    elevation: 4,
                    iconSize: 32,
                    style: inputSubTitleStyle,
                    underline: Container(
                      height: 0,
                    ),
                    items: reminderList.map((int value) {
                      return new DropdownMenuItem<int>(
                        value: value,
                        child: new Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        _selectedReminder = newVal!;
                      });
                    }),
              ),
              CustomInputForm(
                title: "Repeat",
                hint: _selectedRepeat,
                widget: DropdownButton<String>(
                    elevation: 4,
                    iconSize: 32,
                    style: inputSubTitleStyle,
                    underline: Container(
                      height: 0,
                    ),
                    items: repeatList.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        _selectedRepeat = newVal!;
                      });
                    }),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  _colorPallete(),
                  Spacer(),
                  homeBtn(
                      label: "Create Task",
                      onTap: () => {_validateData(), _addTaskToDb()})
                ],
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

  _addTaskToDb() async {
    int returnId = await homeTaskController.addTask(
      task: Task(
          note: _noteController.text,
          title: _titleController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _selectedStartTime,
          endTime: _selectedEndTime,
          remind: _selectedReminder,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isCompleted: 0),
    );

    print(returnId);
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      Get.back();
    } else {
      Get.snackbar("Required", "All fields are Required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  _colorPallete() {
    return Column(
      children: [
        const Text(
          "Color",
        ),
        SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) => GestureDetector(
              onDoubleTap: () => {
                setState(() {
                  _selectedColor = index;
                })
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : yellowClr,
                    child: _selectedColor == index
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container()),
              ),
            ),
          ),
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1945),
        lastDate: DateTime(2121));

    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }

  _getTimeFromUser({required bool isStartedTime}) async {
    var pickedDate = await _showTimePicker();

    // ignore: use_build_context_synchronously
    String formatedTime = await pickedDate.format(context);
    if (pickedDate == null) {
      // ignore: avoid_print
      print("Null pickedDate");
    } else if (isStartedTime == true) {
      setState(() {
        _selectedStartTime = formatedTime;
      });
    } else if (isStartedTime == false) {
      setState(() {
        _selectedEndTime = formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
        hour: int.parse(_selectedStartTime.split(":")[0]),
        minute: int.parse(_selectedStartTime.split(":")[1].split(" ")[0]),
      ),
    );
  }
}
