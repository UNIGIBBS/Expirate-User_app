import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key? key, required this.hintText, required this.icon, required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      elevation: 20,
      child: Container(
        height:  size.height* 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
            color: Color(0xffa1c6ea),
            borderRadius: BorderRadius.circular(30)),

        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 0, 8),
          child: TextField(
              decoration: InputDecoration(
              icon: Icon(
                icon,
                color: Colors.blue,
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.white
              ),
              border: InputBorder.none
          ),

      ),
        ),),
    );
  }
}