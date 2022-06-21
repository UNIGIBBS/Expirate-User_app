import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp2/pages/detail_page.dart';
import 'package:comp2/widgets/edit_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/user_model.dart';
import '../pages/favorite_page.dart';
import 'decoration.dart';

class cardList extends StatefulWidget {
  cardList({Key? key, required this.data}) : super(key: key);

  var data;
  @override
  State<cardList> createState() => _cardListState();
}

class _cardListState extends State<cardList> {
  var currentItem = itemList.getData;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  var info;

  @override
  void initState() {
    super.initState();
    getImage();
  }


  getImage()async{
    var data = FirebaseFirestore.instance.collection("Products").snapshots();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: width / 2.5 + 90 + height * 0.085,

      child: StreamBuilder<QuerySnapshot>(
        stream: widget.data,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text("something went wrong");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator()
              ),
            );
          }

          final data = snapshot.requireData;
          return ListView.builder(

            scrollDirection: Axis.horizontal,
            itemCount: data.docs.length,
            itemBuilder: (context, index) {
              var brand = data.docs[index]["brand"];
              var image = data.docs[index]["image"];
              var title = data.docs[index]["title"];
              var price = data.docs[index]["price"];
              var expiryDate = data.docs[index]["expiry date"];
              var discount = data.docs[index]["discount"];
              var market = data.docs[index]["market"];
              return Card(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 20, 32, 12),
                          child: Container(
                                      height: width / 2.7,
                                      width: width / 2.7,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(image),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.5),
                                            blurRadius: 5.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(
                                              0.0,
                                              3.0,
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Container(
                              height: height * 0.03,
                              child: FittedBox(
                                child: Text(
                                  price,
                                  style: GoogleFonts.openSans(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 4, 0, 0),
                          child: Container(
                            height: 2,
                            width: width / 3,
                            color: Colors.grey[300],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 4, 0, 4),
                          child: Container(
                              height: height * 0.03,
                              child: FittedBox(
                                child: Text(
                                  title,
                                  style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
                          child: Container(
                              height: height * 0.025,
                              child: FittedBox(
                                child: Text(
                                  brand,
                                  style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      ],
                    ),
                    editButton(
                        productInfo: {
                          "brand": brand,
                          "title": title,
                          "image": image,
                          "price": price,
                          "expiry date": expiryDate,
                          "discount": discount,
                          "market": market,
                        }
                    )
                  ],
                ),
              );
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: Container(
              //     width: width/2.3,
              //     color: Colors.red,
              //     child: GestureDetector(
              //       onTap: () {
              //         Navigator.push(context,
              //             MaterialPageRoute(builder: (context) => DetailPage()));
              //       },
              //       child: Stack(
              //         children: [
              //           Card(
              //             elevation: 4,
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(10)),
              //             child:
              //
              //             Padding(
              //               padding: EdgeInsets.fromLTRB(12, 10, 7, 7),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Padding(
              //                     padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
              //                     child: GestureDetector(
              //                       onTap: () {
              //                         Navigator.push(
              //                             context,
              //                             MaterialPageRoute(
              //                                 builder: (context) => DetailPage()));
              //                       },
              //                       child: Container(
              //                         height: width/3,
              //                         width:  width/3,
              //                         decoration: BoxDecoration(
              //                           color: customBackground,
              //                           borderRadius: BorderRadius.all(
              //                             Radius.circular(8.0),
              //                           ),
              //                           boxShadow: [
              //                             BoxShadow(
              //                               color: Colors.grey.withOpacity(.5),
              //                               blurRadius: 3.0,
              //                               spreadRadius: 0.0,
              //                               offset: Offset(
              //                                 0.0,
              //                                 3.0,
              //                               ),
              //                             ),
              //                           ],
              //                           image: DecorationImage(
              //                             image: NetworkImage(
              //                               currentItem[index]['thumbnail'].toString(),
              //                             ),
              //                             fit: BoxFit.cover,
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: height*0.03,
              //                     child: FittedBox(
              //                       child: Text(
              //                         currentItem[index]['price'].toString(),
              //                         style: GoogleFonts.openSans(
              //                           color: Colors.redAccent,
              //                           fontWeight: FontWeight.bold
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   // Divider(
              //                   //   height: 0,
              //                   //   thickness: 1,
              //                   //   endIndent: 20,
              //                   //   color: Colors.black26,
              //                   // ),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   SizedBox(
              //                     height: height*0.03,
              //                     child: FittedBox(
              //                       child: Text(
              //                         currentItem[index]['name'].toString(),
              //                         style: GoogleFonts.openSans(
              //                             color: Colors.black,
              //                             fontWeight: FontWeight.bold
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   SizedBox(
              //                     height: height*0.025,
              //                     child: FittedBox(
              //                       child: Text(
              //                         currentItem[index]['brand'].toString(),
              //                         style: GoogleFonts.openSans(
              //                             color: Colors.black,
              //                             fontWeight: FontWeight.bold
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //
              //
              //           ),
              //           editButton(),
              //         ],
              //       ),
              //     ),
              //   ),
              // );
            },
          );
        }
      ),
    );
  }
}

class itemList {
  static final getData = [
    {
      'name': 'Süt 1 L',
      'thumbnail':
          'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'brand': 'Pınar',
      'price': '8,95 TL',
    },
    {
      'name': 'Jumbo Sosis 330 G',
      'thumbnail':
          'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/13502537/13502537-4a40e0-1650x1650.jpg',
      'brand': 'Banvit ',
      'price': '10.95 TL',
    },
    {
      'name': 'Masterpieces Naneli Bitter Çikolata 115 G',
      'thumbnail':
          'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/07037171/07037171-24f4ce-1650x1650.jpg',
      'brand': 'Godiva ',
      'price': '25,36 TL',
    },
    {
      'name': 'Penne Rigate (Kalem) Makarna 500 G',
      'thumbnail':
          'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/05030342/05030342-027738-1650x1650.jpg',
      'brand': 'Barilla',
      'price': '4,90 TL',
    },
    {
      'name': '15li L Boy Yumurta (63-72 G)',
      'thumbnail':
          'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/20001975/20001975-cdebd9-1650x1650.jpg',
      'brand': 'Yumurtacım',
      'price': '14,50 TL',
    },
  ];
}
