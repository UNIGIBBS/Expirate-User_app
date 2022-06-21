import 'package:flutter/material.dart';

class add_button extends StatelessWidget {
  const add_button({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: .8,
              offset: Offset(.0, 1.5),
            ),
          ],
        ),
        child: IconButton(
          constraints:
              BoxConstraints(maxHeight: height * 0.2, maxWidth: width * 0.2),
          onPressed: () async {},
          iconSize: 20,
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ));
  }
}
