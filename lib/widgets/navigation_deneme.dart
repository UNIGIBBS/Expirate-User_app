import 'package:flutter/material.dart';

import '../pages/favorite_page.dart';
import '../pages/home_page.dart';
import '../pages/last_shopping_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
class NavBarDeneme extends StatefulWidget {
  const NavBarDeneme({Key? key}) : super(key: key);

  @override
  State<NavBarDeneme> createState() => _NavBarDenemeState();
}

class _NavBarDenemeState extends State<NavBarDeneme> {

  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffd6f5ff),

                Color(0xffFFFFFC),

              ]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              physics:NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                lastShopping(),
                SearchPage(),
                HomePage(),
                favoritePage(),
                ProfilePage(),
              ],
            ),
            Positioned(
                bottom: 30,
                child: Container(
                  height: 60,
                  width: width-50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xff677db7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: (){
                            pageController.jumpToPage(0);
                            setState(() {
                            });
                          },
                          icon: Icon(Icons.home, color: Colors.redAccent == 0 ? Color(0xfff5f749) : Colors.white,)
                      ),
                      IconButton(
                          onPressed: (){
                            pageController.jumpToPage(1);
                            setState(() {

                            });
                          },
                          icon: Icon(Icons.search, color: Colors.redAccent == 1 ? Color(0xfff5f749) : Colors.white,)
                      ),
                      IconButton(
                          onPressed: (){
                            pageController.jumpToPage(2);
                            setState(() {

                            });
                          },
                          icon: Icon(Icons.people, color: Colors.redAccent == 2 ? Color(0xfff5f749) : Colors.white,)
                      ),
                      IconButton(
                          onPressed: (){
                            pageController.jumpToPage(3);
                            setState(() {

                            });
                          },
                          icon: Icon(Icons.people, color: Colors.redAccent == 2 ? Color(0xfff5f749) : Colors.white,)
                      ),
                      IconButton(
                          onPressed: (){
                            pageController.jumpToPage(4);
                            setState(() {

                            });
                          },
                          icon: Icon(Icons.account_circle, color: Colors.redAccent == 3 ? Color(0xfff5f749) : Colors.white,)
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
