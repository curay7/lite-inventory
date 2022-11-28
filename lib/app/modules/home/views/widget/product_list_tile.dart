import 'package:first/app/data/model/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../layout/themes.dart';

class ProductListTile extends StatelessWidget {
  final Task? task;
  ProductListTile(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xFFF1F4F8),
        ),
        child: Row(children: [
          Container(
            width: 80,
            height: 70,
            margin: EdgeInsets.only(right: 20),
            color: Colors.transparent,
            child: Image(
              image: AssetImage("assets/images/box-transparent.png"),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: grayClr),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.gif_box,
                              color: grayClr,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Quantity : ${task!.qty}",
                              style: GoogleFonts.lato(
                                textStyle:
                                    TextStyle(fontSize: 13, color: grayClr),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.gif_box,
                              color: grayClr,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "SKL : ${task!.skl}",
                              style: GoogleFonts.lato(
                                textStyle:
                                    TextStyle(fontSize: 13, color: grayClr),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  task?.note ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: grayClr),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: grayClr,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task!.isCompleted == 1 ? "Out Stock" : "In Stock",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.bold, color: grayClr),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return primaryClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return primaryClr;
    }
  }
}
