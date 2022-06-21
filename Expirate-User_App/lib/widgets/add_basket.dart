import 'package:flutter/material.dart';

import 'add_button.dart';

class add_basket extends StatefulWidget {
  @override
  State<add_basket> createState() => _add_basketState();
}

class _add_basketState extends State<add_basket> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
      top: 15,
      left: 80,
      child: add_button(height: height, width: width),
    );
  }
}
