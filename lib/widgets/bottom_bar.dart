import 'package:comp2/pages/payment_page.dart';
import 'package:flutter/material.dart';

import 'continue_button.dart';
import 'delete_button.dart';

class bottom_bar extends StatelessWidget {
  const bottom_bar({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          children: [
            delete_button(width: width, height: height),
            new Spacer(),
            continue_button(
              width: width,
              height: height,
              text: "Continue",
              page: PaymentPage(),
            ),
          ],
        ),
      ),
      height: height * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: const Offset(
              5.0,
              0.0,
            ),
          ),
        ],
      ),
    );
  }
}
