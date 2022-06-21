import 'package:flutter/material.dart';

class addButton extends StatelessWidget {

   addButton({Key? key}) : super(key: key);

   Color customOceanBlue = Color(0xff638181);
   Color customBackgroundWhite = Colors.white;


   @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: customOceanBlue,
      foregroundColor: customBackgroundWhite,
      onPressed: () {},
      child: const Icon(
        Icons.add,
        size: 35,
      ),
    );
  }
}