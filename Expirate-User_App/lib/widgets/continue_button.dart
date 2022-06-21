import 'package:comp2/pages/payment_page.dart';
import 'package:flutter/material.dart';

import 'decoration.dart';

const Color customBackground = Color(0xffe6e6ec);

class continue_button extends StatelessWidget {
  const continue_button({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.page,
  }) : super(key: key);

  final double width;
  final double height;
  final String text;
  final page;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: customBackground,
          fixedSize: Size(width * 0.6, height * 0.07),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Text(
        text,
        style: style_arguments(
            Colors.black, FontWeight.w600, height * 0.022, 'OpenSans'),
      ),
    );
  }
}
