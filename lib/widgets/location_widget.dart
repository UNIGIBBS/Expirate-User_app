import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/map_page.dart';

class Location extends StatelessWidget {
  const Location({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kayseri, Kocasinan",
                  style: TextStyle(
                      fontSize: height*0.015,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.1
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8,8,8),
                  child: Container(
                    height: 1,
                    width: width/2,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "Abdullah Gul univercity sumer campus",
                  style: TextStyle(
                    fontSize: height*0.02,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent,
                  ),
                  child: Icon(
                    CupertinoIcons.location,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
