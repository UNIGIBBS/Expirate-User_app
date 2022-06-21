import 'package:flutter/material.dart';


class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key, required this.onChanged, required this.title
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      elevation: 20,
      child: Container(

          width: size.width * 0.8,
          height: size.height* 0.08,
          decoration: BoxDecoration(
              color: Color(0xffa1c6ea),
              borderRadius: BorderRadius.circular(30)),

          child:  Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 0, 8),
            child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(

              hintText: title,
              hintStyle: TextStyle(color: Colors.white),
              icon: Icon(Icons.lock,
                color: Colors.blue,),
              suffixIcon: Icon(Icons.visibility,
                color: Colors.blue,),
              border: InputBorder.none
        ),
      ),
          )),
    );
  }
}