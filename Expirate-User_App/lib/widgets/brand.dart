import 'package:flutter/material.dart';

import '../pages/others_page.dart';
class Brand extends StatelessWidget {
  const Brand({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: width/8,
      child: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Container(
                height: width/8,
                width: width/4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("assets/images/a101.jpg"),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Container(
                height: width/8,
                width: width/4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("assets/images/bim_2.png"),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Container(
                height: width/8,
                width: width/4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("assets/images/migros.jpg"),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: width/8,
                width: width/4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("assets/images/sok_2.png"),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context) => OthersPage()));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: width/8,
                  width: width/4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Text(
                              "Others",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 15,)
                          ],
                        ),
                      )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


