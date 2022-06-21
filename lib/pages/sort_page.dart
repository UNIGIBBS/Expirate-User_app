import 'package:comp2/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import '../widgets/decoration.dart';
class SortPage extends StatefulWidget {
  const SortPage({Key? key}) : super(key: key);

  @override
  State<SortPage> createState() => _SortPageState();
}


class _SortPageState extends State<SortPage> {
  @override
  String? val = '';
  List sortList = ["Highest Price", "Lowest Price", "Bestsellers", "The Newests"];
  Widget build(BuildContext context) {
    Widget makeDismissible({required Widget child}) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(onTap: (){}, child: child,),
    );
    final products = Provider.of<Products>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: makeDismissible(
        child: DraggableScrollableSheet(
          maxChildSize:0.8,
          minChildSize: 0.3,
          initialChildSize: 0.8,
          builder: (_,controller) =>
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                padding: EdgeInsets.all(16),
                child: ListView(
                  controller: controller,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: sortList.length,
                      itemBuilder: (context, index) {
                        return RadioListTile<String>(
                          title: Text(sortList[index], style: style_arguments(
                              Colors.black.withOpacity(0.8), FontWeight.normal, 18, 'Open Sans'),),
                          value: sortList[index],
                          groupValue: val,
                          onChanged: (value) {
                            setState(
                                  () {
                                val = value;
                              },
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 30,),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.deepOrange,
                        ),
                        child: TextButton(
                          onPressed: () {
                            products.filterList(val);
                          },
                          child: Text(
                            "OK",
                            style: style_arguments(
                                Colors.white, FontWeight.bold, 15, 'Open Sans'),
                          ),
                        ),
                      ),
                    ),],
                ),
              ),
        ),
      ),
    );
  }
}

