
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp2/providers/product_list.dart';
import 'package:comp2/services/map_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class MarketPage extends StatefulWidget {
  MarketPage({Key? key, required this.id}) : super(key: key);
  var id;

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {

  List<Widget> categorie = [
    DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.redAccent,style: BorderStyle.solid, width: 2)
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Tab(
          text: "All products",
        ),
      ),
    )
  ];

  var productList;

  var cats = [];

  var data;
  var generalInfo;
  var fakeList;

  var image;
  var city;
  var username;
  var lat;
  var lng;
  var address;
  var village;

  void initState() {
    super.initState();
    getData();
  }

  getData()async{
    
    var length = 0;

    productList = [];
    fakeList = [];

    await FirebaseFirestore.instance.collection("Markets").doc(widget.id).get().then((value){
      print(value["image"]);
      username = value["username"];
      image = value["image"];
      address = value["address"];
      city = value["city"];
      lat = value["lat"];
      village = value["village"];
      lng = value["lng"];
    });

    generalInfo = await FirebaseFirestore.instance.collection("Markets").doc(widget.id).collection("products").get().then((value){
      List<MarketProductWidget> elementList = [];
      value.docs.forEach((element) {
        elementList.add(
            MarketProductWidget(model: ProductModel(brand: element["brand"], date: element["expiry date"], price: element["price"], url: element["image"], name: element["title"]))
        );
      });
      productList = ListView(
        children: elementList,
      );
      fakeList.add("generalInfo");
      print("first ${fakeList}");
    });

  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        title: Text("Sumer Market"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }else{
                  return Stack(
                    children: [
                      Container(
                        height: width / 2 * 0.9,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(image),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            MapUtils.openMap(38.748787, 35.468275);
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.redAccent,
                            ),
                            child: Icon(Icons.location_on, color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            ),
          ),
          FutureBuilder(
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }else{
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Location  ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.022,
                                  fontStyle: FontStyle.italic
                              )
                          ),
                          TextSpan(
                              text: "Kayseri / Kocasinan / Sumer mahallesi / Next to the university",
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: height*0.02,
                              )
                          )
                        ]
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(width*0.01, 0, width*0.01, 0),
            child: Divider(
              thickness: 3,
              color: Colors.grey[400],
            ),
          ),
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              print(fakeList);
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else{
                return DefaultTabController(
                  length: 1,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TabBar(
                            isScrollable: true,

                            unselectedLabelColor: Colors.black,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.redAccent),

                            tabs: categorie,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(width*0.01, 0, width*0.01, 0),
                        child: Divider(
                          thickness: 3,
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(
                        height: 580,
                        child: TabBarView(
                          children: [
                            productList
                          ]
                        ),
                      )
                    ],
                  ),
                );
              }
            }
          ),
        ],
      ),
    );
  }
}

class MarketProductWidget extends StatelessWidget {
  MarketProductWidget({
    Key? key,
    required this.model
  }) : super(key: key);

  ProductModel model;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: width,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: width/2.5-16,
                              width: width/2.5-16,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(model.url!),
                                    fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.name!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height*0.02,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 5,),
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Size: ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: height*0.02,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      TextSpan(
                                        text: "1 Lt",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: height*0.02
                                        ),
                                      )
                                    ]
                                ),
                              ),
                              SizedBox(height: 5,),
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Expiry date: ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: height*0.02,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${model.date!.toDate().day}/${model.date!.toDate().month}/${model.date!.toDate().year}",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontStyle: FontStyle.italic,
                                            fontSize: height*0.02
                                        ),
                                      )
                                    ]
                                ),
                              ),
                              SizedBox(height: 5,),
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Quantity: ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: height*0.02,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      TextSpan(
                                        text: "1",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: height*0.02
                                        ),
                                      )
                                    ]
                                ),
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(width*0.05, 0, width*0.05, 0),
              child: Divider(
                thickness: 3,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 32,
          right: 16,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.redAccent, style: BorderStyle.solid,width: 2)
            ),
            child: Padding(
                padding: EdgeInsets.all(8),
                child: const Icon(Icons.add, color: Colors.redAccent,)
            ),
          ),
        )
      ],
    );
  }
}
