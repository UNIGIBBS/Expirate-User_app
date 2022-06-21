import 'package:comp2/pages/home_page.dart';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';


import '../widgets/basket_icon.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/counter.dart';
import '../widgets/decoration.dart';
import '../widgets/divider.dart';
import '../widgets/item_pic.dart';

class MyBasket extends StatelessWidget {
  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData? basket_1 =
  IconData(0xe911, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.keyboard_backspace),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
            color: Colors.black,
            alignment: Alignment.centerLeft,
          ),
        ),
        title: Text('My Basket',
            style: style_arguments(
                Colors.black, FontWeight.w600, height * 0.028, 'OpenSans')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: basket_icon(),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomSheet: bottom_bar(width: width, height: height),
      body: ListView(
        children: [
          cardList(),
        ],
      ),

    );
  }
}

class cardList extends StatefulWidget {
  cardList({Key? key}) : super(key: key);

  @override
  State<cardList> createState() => _cardListState();
}

class _cardListState extends State<cardList> {
  var currentItem = itemList.getData;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: currentItem.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                height: height * 0.2,
                child: Column(
                  children: [
                    Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: item_pic(
                              width: width,
                              height: height,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Container(
                              width: width * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: height * 0.08,
                                    child: Column(
                                      children: [
                                        Flexible(
                                          child: RichText(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              text: currentItem[index]['brand']
                                                  .toString(),
                                              style: style_arguments(
                                                  Colors.redAccent[400],
                                                  FontWeight.w800,
                                                  height * 0.021,
                                                  'OpenSans'),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: ('\t'),
                                                ),
                                                TextSpan(
                                                  text: currentItem[index]
                                                  ['name']
                                                      .toString(),
                                                  style: style_arguments(
                                                      Colors.black,
                                                      FontWeight.w400,
                                                      height * 0.02,
                                                      'OpenSans'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Text(
                                    currentItem[index]['amount'].toString(),
                                    style: style_arguments(
                                        Colors.black.withOpacity(0.5),
                                        FontWeight.w400,
                                        height * 0.02,
                                        'OpenSans'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                counter(space: 10, size: 25,),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  currentItem[index]['price'].toString(),
                                  style: style_arguments(
                                      Colors.black,
                                      FontWeight.w600,
                                      height * 0.023,
                                      'OpenSans'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    divider(
                      color: Colors.black54.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class itemList {
  static final getData = [
    {
      'name': 'name1 name1 name1 name1 name1name1name1',
      'thumbnail': 'thumbnail1',
      'brand': 'brand1',
      'amount': 'amount1',
      'price': '56.90',
    },
    {
      'name': 'name2',
      'thumbnail': 'thumbnail2',
      'brand': 'brand2',
      'amount': 'amount2',
      'price': '56.90',
    },
    {
      'name': 'name3name3name3name3',
      'thumbnail': 'thumbnail3',
      'brand': 'brand3',
      'amount': 'amount2',
      'price': '56.90',
    },
  ];
}
