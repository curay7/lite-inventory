import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:first/app/data/services/theme_services.dart';
import 'package:first/app/modules/home/views/home_update_product.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/model/product.dart';
import '../../layout/themes.dart';
import '../controllers/home_controller.dart';
import 'package:intl/intl.dart';

import 'widget/product_tile.dart';
import 'widget/product_tile_warning.dart';

final _homeController = Get.find<HomeController>();

DateTime _updateinitialSelectedDate = DateTime.now();

class HListUpdateProduct extends GetView<HomeController> {
  const HListUpdateProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: _appBar(),
        backgroundColor: context.theme.backgroundColor,
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // Generated code for this Container Widget...
            InkWell(
              onTap: () async {
                // _fabAnimationController.reset();
                // _borderRadiusAnimationController.reset();
                // _borderRadiusAnimationController.forward();
                // _fabAnimationController.forward();
                // print("TEST Next Page");
                // await Get.to(QRViewExample());
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', 'Cancel', true, ScanMode.QR);
                await Get.to(HListUpdateProduct());
                print(
                    "TEST Barcode!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${barcodeScanRes}");
              },
              child: Align(
                alignment: AlignmentDirectional(-0.05, 0.05),
                child: Material(
                  color: Colors.transparent,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F4F8),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            color: Color(0xFF101213),
                            size: 90,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 17,
            ),
            _showSelectedDateProduct()
          ],
        ),
      ),
    );
  }

  _showSelectedDateProduct() {
    return Expanded(
      child: Obx(
        (() {
          return Stack(
            children: [
              ((_homeController.selectedDate.value.day != DateTime.now().day) ||
                      (_homeController.selectedDate.value.month !=
                          DateTime.now().month) ||
                      (_homeController.selectedDate.value.year !=
                          DateTime.now().year))
                  ? Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            _homeController.selectedDate.value = DateTime.now();
                          },
                          child: Icon(Icons.repeat)),
                    )
                  : Container(),
              Padding(
                padding: ((_homeController.selectedDate.value.day !=
                            DateTime.now().day) ||
                        (_homeController.selectedDate.value.month !=
                            DateTime.now().month) ||
                        (_homeController.selectedDate.value.year !=
                            DateTime.now().year))
                    ? const EdgeInsets.only(top: 50)
                    : EdgeInsets.all(0),
                child: ListView.builder(
                  itemCount: _homeController.productList.length,
                  itemBuilder: ((context, index) {
                    Product product = _homeController.productList[index];

                    print(
                        "Test 1 ${_homeController.selectedDate.value.day}  Test 2 ${DateTime.now().day}");
                    if ((_homeController.selectedDate.value.day ==
                            DateTime.now().day) &&
                        (_homeController.selectedDate.value.month ==
                            DateTime.now().month) &&
                        (_homeController.selectedDate.value.year ==
                            DateTime.now().year)) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      print(_homeController.selectedDate.value);
                                      _showBottomSheet(context, product);
                                    },
                                    child: ProductTile(product),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    if (product.date ==
                        DateFormat.yMd()
                            .format(_homeController.selectedDate.value)) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                                child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _showBottomSheet(context, product);
                                    },
                                    child: ProductTileWarning(product),
                                  ),
                                )
                              ],
                            )),
                          ));
                    }

                    return Container();
                  }),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Product product) {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 4),
      height: MediaQuery.of(context).size.height * 0.40,
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
          _bottomSheetBotton(
              label: "Update Product",
              onTap: () {
                _homeController.findProductUpdate(product.id!);
                Get.to(HomeUpdateProduct());
              },
              color: primaryClr,
              context: context),
          _bottomSheetBotton(
              label: "Delete Product",
              onTap: () {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Warning",
                  desc: "This Product will not be retrive after it deleted",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        final snackBar = SnackBar(
                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Delete Product!',
                            message: 'The Product has been deleted',

                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType: ContentType.success,
                          ),
                        );

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                        _homeController.delete(product);

                        Get.back();
                      },
                      color: Color.fromRGBO(0, 179, 134, 1.0),
                    ),
                    DialogButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(116, 116, 191, 1.0),
                        Color.fromRGBO(52, 138, 199, 1.0)
                      ]),
                    )
                  ],
                ).show();
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
          Spacer()
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
      // leading: GestureDetector(
      //   onTap: () {
      //     ThemeServices().switchTheme();
      //     _homeController.sendNotification('Theme Change',
      //         Get.isDarkMode ? "Activated Light Mode" : "Activated Dark Mode");
      //   },
      //   child: Icon(CupertinoIcons.moon_stars,
      //       size: 20, color: Color.fromARGB(255, 110, 108, 108)),
      // ),
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

  _addProductBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 12,
        ),
        GestureDetector(
          onTap: () {
            ThemeServices().switchTheme();
            _homeController.sendNotification(
                'Theme Change',
                Get.isDarkMode
                    ? "Activated Light Mode"
                    : "Activated Dark Mode");
          },
          child: Icon(
            CupertinoIcons.moon_stars,
            size: 50,
            color: Color.fromARGB(255, 110, 108, 108),
            shadows: <Shadow>[
              Shadow(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  blurRadius: 15.0)
            ],
          ),
        ),
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
        initialSelectedDate: _homeController.selectedDate.value,
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
          _homeController.getProduct();
          _homeController.selectedDate.value = date;
        },
      ),
    );
  }
}
