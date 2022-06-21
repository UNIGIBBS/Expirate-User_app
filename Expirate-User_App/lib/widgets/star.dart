import 'package:flutter/material.dart';

class Star extends StatefulWidget {
  Star({Key? key, required this.form}) : super(key: key);

  double form;

  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> {

  var icon;

  @override
  Widget build(BuildContext context) {
    if(widget.form==0){
      icon = Icon(Icons.star_outline, color: Colors.red, size: 30,);
    }
    if(widget.form==0.5){
      icon = Icon(Icons.star_half_rounded, color: Colors.red, size: 30,);
    }
    if(widget.form==1){
      icon = Icon(Icons.star_outlined, color: Colors.red, size: 30,);
    }
    return icon;
  }
}
