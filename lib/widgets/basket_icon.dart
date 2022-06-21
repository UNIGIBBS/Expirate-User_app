import 'package:comp2/pages/my_basket_page.dart';
import 'package:flutter/material.dart';

import 'decoration.dart';

const Color customBackground = Color(0xffe6e6ec);

class basket_icon extends StatelessWidget {
  const basket_icon({Key? key}) : super(key: key);
  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData? basket_1 =
      IconData(0xe911, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: customBackground,
          fixedSize: Size(width * 0.25, height * 0.07),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyBasket()));
      },
      child: Row(
        children: [
          Icon(
            basket_1,
            color: Colors.black,
          ),
          SizedBox(
            width: width * 0.01,
          ),
          Text('56.90',
              style: style_arguments(
                  Colors.black, FontWeight.w600, height * 0.022, 'OpenSans')),
        ],
      ),
    );
  }
}
