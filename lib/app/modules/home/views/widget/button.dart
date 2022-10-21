import 'package:first/app/modules/layout/themes.dart';
import 'package:flutter/material.dart';

class homeBtn extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const homeBtn({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 100,
          height: 45,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: primaryClr),
          // Change button text when light changes state.
          child: Center(
            child: Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
