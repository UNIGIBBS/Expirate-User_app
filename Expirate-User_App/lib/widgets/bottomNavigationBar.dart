import 'package:comp2/pages/favorite_page.dart';
import 'package:comp2/pages/last_shopping_page.dart';
import 'package:comp2/pages/profile_page.dart';
import 'package:comp2/pages/search_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';


class BottomNavigate extends StatefulWidget {
  const BottomNavigate({Key? key}) : super(key: key);

  @override
  State<BottomNavigate> createState() => _BottomNavigateState();
}

class _BottomNavigateState extends State<BottomNavigate> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final items = <Widget> [
    Icon(Icons.menu, size: 30,),


    Icon(Icons.home, size: 30,),
    Icon(Icons.search, size: 30,),
    Icon(Icons.person, size: 30,)

  ];
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  final screens = [
    lastShopping(),

    HomePage(),
    SearchPage(),
    ProfilePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color:Colors.white)
        ),
        child: CurvedNavigationBar(
          key: navigationKey,
          color: Color(0xffA9A9A9),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.redAccent,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          index: index,
          items: items,
          onTap: (index) => setState(() => this.index = index) ,

        ),
      ),
    );
  }
}
