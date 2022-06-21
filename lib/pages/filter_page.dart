import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp2/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import '../widgets/decoration.dart';

class FilterPage extends StatefulWidget {
  FilterPage({Key? key, required this.categories}) : super(key: key);

  var categories;

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  String? val = '';
  String? val2 = '';
  String? val3 = '';
  String? val4 = '';
  double _currentSliderValue = 20;
  bool _value = false;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    Widget makeDismissible({required Widget child}) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );

    final products = Provider.of<Products>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: makeDismissible(
        child: DraggableScrollableSheet(
          maxChildSize: 0.8,
          minChildSize: 0.3,
          initialChildSize: 0.8,
          builder: (_, controller) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            padding: EdgeInsets.all(16),
            child: ListView(
              controller: controller,
              children: [
                Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: Column(
                      children: [
                        ...widget.categories.map(buildCheckboxListTile).toList(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: (){

                            },
                            child: Icon(Icons.search),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.redAccent)
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCheckboxListTile(CheckBoxState checkbox) {
    return CheckboxListTile(
      value: checkbox.value,
      onChanged: (value) => setState(() => checkbox.value = value!),
      title: Text(
        checkbox.title,
        style: style_arguments(
            Colors.black.withOpacity(0.8), FontWeight.normal, 20, 'Open Sans'),
      ),
    );
  }
}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({required this.title, this.value = false});
}
