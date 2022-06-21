import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../pages/search_page.dart';
import 'decoration.dart';

const Color customBackground = Color(0xffe6e6ec);

class search_bar extends StatelessWidget {
  const search_bar({
    Key? key,
    required this.focus,
  }) : super(key: key);

  final bool focus;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: TextField(
        autofocus: focus,
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchPage()));
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search",
          hintStyle: style_arguments(
              Colors.grey[600], FontWeight.w400, height * 0.022, 'OpenSans'),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none),
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}
