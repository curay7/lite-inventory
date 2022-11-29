import 'dart:ffi';

import 'package:first/app/data/model/product.dart';
import 'package:first/app/modules/home/views/widget/button.dart';
import 'package:first/app/modules/home/views/widget/input_field.dart';
import 'package:first/app/modules/layout/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/model/product.dart';
import '../controllers/home_controller.dart';
import 'widget/input_field_number.dart';

class HomeAddProduct extends StatefulWidget {
  const HomeAddProduct({Key? key}) : super(key: key);

  @override
  State<HomeAddProduct> createState() => _HomeAddProductState();
}

class _HomeAddProductState extends State<HomeAddProduct> {
  final HomeController homeProductController = Get.put(HomeController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _skiController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final _homeController = Get.find<HomeController>();

  late String _barcode = "";
  DateTime _selectedDate = DateTime.now();
  String _selectedStartTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectedEndTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();

  int _selectedReminder = 7;
  List<int> reminderList = [1, 2, 3, 4, 5, 6, 7];

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
                "Add Product",
                style: headingStyle,
              ),
              CustomInputForm(
                title: "Name",
                controller: _titleController,
              ),
              InkWell(
                onTap: () async {
                  scanBarcodeNormal();
                  print(_barcode);
                },
                child: Container(
                  width: double.infinity,
                  child: CustomInputForm(
                      title: "Barcode",
                      hint: _barcode,
                      widget: Icon(Icons.qr_code_scanner)),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInputFormNumber(
                      title: "SKL",
                      controller: _skiController,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: CustomInputFormNumber(
                      title: "Quantity",
                      controller: _qtyController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 1,
                    width: 100,
                    color: Colors.black,
                  ),
                  Text("Other Delivery"),
                  Container(
                    height: 1,
                    width: 100,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
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
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  //    _colorPallete(),
                  Spacer(),
                  homeBtn(label: "Create", onTap: () => {_validateData()})
                ],
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

  _addProductToDb() async {
    int returnId = await homeProductController.addProduct(
      product: Product(
          note: _barcode,
          qty: int.parse(_skiController.text),
          skl: int.parse(_qtyController.text),
          title: _titleController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _selectedStartTime,
          endTime: _selectedEndTime,
          remind: _selectedReminder,
          color: 0,
          isCompleted: 0),
    );

    _homeController.getProduct();
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _barcode.isNotEmpty) {
      _addProductToDb();
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

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _barcode = barcodeScanRes;
    });
  }
}
