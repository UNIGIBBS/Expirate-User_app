import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp2/widgets/cardList.dart';
import 'package:flutter/material.dart';

import 'card_list_others.dart';
import 'decoration.dart';

class itemListOthersContainer extends StatefulWidget {
  itemListOthersContainer({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);
  String title;
  var id;

  @override
  State<itemListOthersContainer> createState() => _itemListOthersContainerState();
}

class _itemListOthersContainerState extends State<itemListOthersContainer> {

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: width/2.5 + 98 + height * 0.108,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: const Offset(
                0.0,
                5.0,
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
              child: SizedBox(
                height: height * 0.023,
                child: widget.title!="" ? FittedBox(
                  child: Text(
                    widget.title,
                    style: style_arguments(
                      Colors.black.withOpacity(0.8),
                      FontWeight.w600,
                      height * 0.023,
                      'OpenSans',
                    ),
                    textAlign: TextAlign.start,
                  ),
                ) : Container(),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: cardListOthers(id: widget.id),
                )
            ),
          ],
        ),
      ),
    );
  }
}
