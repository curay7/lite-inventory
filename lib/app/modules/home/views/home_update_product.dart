import 'dart:ffi';

import 'package:first/app/data/model/product.dart';
import 'package:first/app/modules/home/views/widget/button.dart';
import 'package:first/app/modules/home/views/widget/input_field.dart';
import 'package:first/app/modules/layout/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

final _homeController = Get.find<HomeController>();

class HomeUpdateProduct extends StatefulWidget {
  const HomeUpdateProduct({Key? key}) : super(key: key);

  @override
  State<HomeUpdateProduct> createState() => _HomeUpdateProductState();
}

class _HomeUpdateProductState extends State<HomeUpdateProduct> {
  final HomeController homeProductController = Get.put(HomeController());
  final TextEditingController _titleController =
      TextEditingController(text: _homeController.updateProduct.title);
  final TextEditingController _noteController =
      TextEditingController(text: _homeController.updateProduct.note);
  final TextEditingController _skiController =
      TextEditingController(text: _homeController.updateProduct.skl.toString());

  final TextEditingController _qtyController =
      TextEditingController(text: _homeController.updateProduct.qty.toString());

  DateTime _selectedDate = DateTime.now();
  String _selectedStartTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectedEndTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();

  int _selectedReminder = 7;
  List<int> reminderList = [1, 2, 3, 4, 5, 6, 7];

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
  void initState() {
    // TODO: implement initState
  }

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
                "Update Product ${_homeController.updateProduct.title}",
                style: headingStyle,
              ),
              CustomInputForm(
                title: "Name",
                controller: _titleController,
              ),
              CustomInputForm(
                title: "Note",
                controller: _noteController,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInputForm(
                      title: "SKL",
                      hint: 'Enter SKL here',
                      controller: _skiController,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: CustomInputForm(
                      title: "Quantity",
                      hint: "Enter the quantity here",
                      controller: _qtyController,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    // _colorPallete(),
                    Spacer(),
                    homeBtn(label: "Update", onTap: () => {_validateData()})
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
          backgroundImage: AssetImage("assets/images/profile.jpg"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  _updateProductToDb() async {
    Future<int> returnId = homeProductController.updateProductController(
      id: _homeController.updateProduct.id!,
      product: Product(
          note: _noteController.text,
          qty: int.parse(_qtyController.text),
          skl: int.parse(_skiController.text),
          title: _titleController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _selectedStartTime,
          endTime: _selectedEndTime,
          remind: _selectedReminder,
          color: _selectedColor,
          isCompleted: 0),
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _updateProductToDb();
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
