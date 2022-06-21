import 'package:comp2/pages/home_page.dart';
import 'package:comp2/widgets/item_pic.dart';
import 'package:flutter/material.dart';

import '../widgets/decoration.dart';
import '../widgets/divider.dart';
import '../widgets/favorite_button.dart';

void main() => runApp(favoritePage());

class favoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.keyboard_backspace),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      color: Colors.black,
                      alignment: Alignment.centerLeft,
                    ),
                    Text('Favorites',
                        style: style_arguments(Colors.black, FontWeight.w600,
                            height * 0.028, 'OpenSans')),
                  ],
                ),
                divider(
                  color: Colors.black54.withOpacity(0.2),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: height,
                          child: GridView.count(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 0.1,
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 3,
                            childAspectRatio: 0.55,
                            children: List.generate(50, (index) {
                              return Container(
                                child: cardList(),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      child: Stack(
        children: [
          Card(
            color: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 15, 7, 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: item_pic(
                      width: width,
                      height: height,
                    ),
                  ),
                  Text(
                    '56.90',
                    style: style_arguments(Colors.redAccent[400],
                        FontWeight.w800, height * 0.021, 'OpenSans'),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Flexible(
                    child: RichText(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'brand ',
                        style: style_arguments(Colors.redAccent[400],
                            FontWeight.w800, height * 0.021, 'OpenSans'),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'name name name',
                            style: style_arguments(Colors.black,
                                FontWeight.w400, height * 0.02, 'OpenSans'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    'type',
                    style: style_arguments(Colors.black.withOpacity(0.8),
                        FontWeight.w400, height * 0.02, 'OpenSans'),
                  ),
                ],
              ),
            ),
          ),
          favoriteButton(),
        ],
      ),
    );
  }
}
