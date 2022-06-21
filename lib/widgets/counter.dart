import 'package:flutter/material.dart';
import 'package:count_stepper/count_stepper.dart';

class counter extends StatelessWidget {
  const counter({
    Key? key, required this.size, required this.space,
  }) : super(key: key);

  final double size;
  final double space;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(iconTheme: theme.iconTheme.copyWith(size: size),),
      child:
      CountStepper(
        space: space,
        defaultValue: 1,
        max: 25,
        min: 1,
        iconDecrementColor: Color(0xfffe5d5d),
        iconIncrementColor: Color(0xfffe5d5d),
        splashRadius: 15,
        onPressed: (value) {},
      ),);


  }
}
