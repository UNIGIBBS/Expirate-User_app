import 'package:comp2/widgets/search_bar.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import 'basket_icon.dart';
import 'filter_button.dart';

class customAppBar extends StatelessWidget {
  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData basket_1 =
  IconData(0xe911, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  customAppBar({
    Key? key,
    required this.categories
  }) : super(key: key);

  var categories;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 25, 15, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8,10,0,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IntrinsicHeight(
                    child: filter_button(width: width, categories: categories),
                  ),
                  Spacer(),
                  Container(
                    height: height * 0.07,
                    width: width * 0.7,
                    child: search_bar(
                      focus: true,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[300],
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
