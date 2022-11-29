import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../data/flutter_flow/flutter_flow_icon_button.dart';
import '../../../data/flutter_flow/flutter_flow_theme.dart';
import '../../../data/flutter_flow/flutter_flow_widgets.dart';
import '../controllers/home_controller.dart';
import 'home_add_task.dart';
import 'home_update_product.dart';

final HomeController homeProductController = Get.put(HomeController());

class ListUpdateProduct extends StatefulWidget {
  const ListUpdateProduct({Key? key}) : super(key: key);

  @override
  _ListUpdateProductState createState() => _ListUpdateProductState();
}

class _ListUpdateProductState extends State<ListUpdateProduct>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F4F8),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF57636C),
            size: 30,
          ),
          onPressed: () async {
            Get.back();
          },
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'List of Product',
                      style: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF0F1113),
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Divider(
                      height: 24,
                      thickness: 1,
                      color: Color(0xFFE0E3E7),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_scanner_sharp,
                            color: Color(0xFF7C8791),
                            size: 90,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Expanded(
                                //   child: Text(
                                //     'Browse the list to find items you want to update, once the item found, they will appear here.',
                                //     textAlign: TextAlign.center,
                                //     style: FlutterFlowTheme.of(context)
                                //         .bodyText2
                                //         .override(
                                //           fontFamily: 'Outfit',
                                //           color: Color(0xFF7C8791),
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.normal,
                                //         ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                String barcodeScanRes =
                                    await FlutterBarcodeScanner.scanBarcode(
                                        '#ff6666', 'Cancel', true, ScanMode.QR);

                                // This is how I iterate
                                var contain = await homeProductController
                                    .productList
                                    .where((element) =>
                                        element.note == barcodeScanRes);

                                if (contain.isEmpty) {
                                  Alert(
                                    context: context,
                                    type: AlertType.warning,
                                    title: "Product not found pls try again",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "Ok",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(116, 116, 191, 1.0),
                                          Color.fromRGBO(52, 138, 199, 1.0)
                                        ]),
                                      )
                                    ],
                                  ).show();
                                } else {
                                  homeProductController
                                      .findProductByBarcode(barcodeScanRes);
                                  Get.to(ListUpdateProduct());
                                }
                                // await Get.to(HListUpdateProduct());
                                print(
                                    "TEST Barcode!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${barcodeScanRes}");
                                homeProductController.getProduct();
                              },
                              text: 'Scan',
                              options: FFButtonOptions(
                                width: 170,
                                height: 50,
                                color: Color(0xFF4B39EF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 2,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (homeProductController.productListUpdate.isEmpty)
                        ? Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF0F1113),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(HomeAddProduct());
                                },
                                child: Container(
                                  width: 100,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF39D2C0),
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Text(
                                    'Create',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    (homeProductController.productListUpdate.isEmpty)
                        ? Text(
                            'Tuesday, 10:00am',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF4B39EF),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                ),
                          )
                        : Container(),
                    (homeProductController.productListUpdate.isEmpty)
                        ? Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                            child: Text(
                              'Product List',
                              style: FlutterFlowTheme.of(context)
                                  .subtitle1
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF0F1113),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          )
                        : Container(),
                    Column(
                        children: homeProductController.productListUpdate
                            .map((element) => TileUpdateListProduct(
                                  productId: element.id,
                                  productName: element.title,
                                  productStock: element.qty,
                                ))
                            .toList())
                  ],
                ),
              ),
              (homeProductController.productListUpdate.isEmpty)
                  ? Container()
                  : Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 44),
                      child: FFButtonWidget(
                        onPressed: () async {
                          //   context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'You Completed a Product!',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor: Color(0xFF4B39EF),
                            ),
                          );
                        },
                        text: 'Mark as Complete',
                        options: FFButtonOptions(
                          width: 270,
                          height: 50,
                          color: Color(0xFF4B39EF),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Outfit',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class TileUpdateListProduct extends StatelessWidget {
  final String? productName;
  final int? productId;
  final int? productStock;
  const TileUpdateListProduct(
      {required this.productName, required this.productStock, this.productId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              color: Color(0x32171717),
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(
                  width: 40,
                  height: 40,
                  image: AssetImage("assets/images/box-transparent.png"),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${productName}',
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Outfit',
                              color: Color(0xFF0F1113),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.gif_box,
                              color: Colors.grey[700],
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Quantity : ${productStock}",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 13, color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 50,
                icon: Icon(
                  Icons.edit,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30,
                ),
                onPressed: () async {
                  homeProductController.findProductUpdate(productId!);
                  Get.to(HomeUpdateProduct());
                  homeProductController.getProduct();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
