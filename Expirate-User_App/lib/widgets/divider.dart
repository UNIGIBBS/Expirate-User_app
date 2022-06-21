import 'package:flutter/material.dart';

class divider extends StatelessWidget {
  const divider({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: 1.5,
      indent: 15,
      endIndent: 15,
    );
  }
}
