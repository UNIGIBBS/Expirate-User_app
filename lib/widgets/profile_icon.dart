import 'package:comp2/pages/profile_page.dart';
import 'package:flutter/material.dart';

const Color customBackground = Color(0xffe6e6ec);

class profile_icon extends StatelessWidget {
  const profile_icon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: customBackground,
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: IconButton(
        icon: const Icon(Icons.person_outline),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        },
      ),
    );
  }
}
