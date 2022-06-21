import 'package:flutter/material.dart';

const Color customBackground = Color(0xffe6e6ec);

class delete_button extends StatelessWidget {
  const delete_button({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: customBackground,
            fixedSize: Size(width * 0.07, height * 0.07),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {},
        child: Icon(
          Icons.delete,
          color: Colors.black,
        ));
  }
}
