import 'package:comp2/pages/profile_page.dart';
import 'package:comp2/pages/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'decoration.dart';
const Color customBackground = Color(0xffe6e6ec);
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height*0.07,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onSubmitted: (value){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                print(value);
              },
              decoration: InputDecoration(
                prefixIcon:IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                ),
                hintText: "Search",
                hintStyle: style_arguments(
                    Colors.grey[600], FontWeight.w400, height * 0.022, 'OpenSans'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}
