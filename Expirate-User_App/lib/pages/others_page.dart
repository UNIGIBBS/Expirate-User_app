import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp2/pages/favorite_page.dart';
import 'package:comp2/pages/market_page.dart';
import 'package:comp2/widgets/item_list_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/basket_icon.dart';
import '../widgets/item_list_others_container.dart';
import '../widgets/location_widget.dart';
import '../widgets/market_overview.dart';

class OthersPage extends StatefulWidget {
  const OthersPage({Key? key}) : super(key: key);

  @override
  _OthersPageState createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData? basket_1 =
  IconData(0xe911, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  void initState() {
    super.initState();
    getData();
  }

  var data;
  
  getData()async{
    data = FirebaseFirestore.instance.collection("Markets").snapshots();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Location(),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: data,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else{

                final main = snapshot.requireData;
                print("length");
                print(main.docs.length);

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: main.docs.length,
                  itemBuilder: (context, index){
                    print(main.docs[0].id);
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MarketPage(id: main.docs[index].id)));
                            },
                              child: MarketOverview(rate: 3.7, type: "Search", name: main.docs[index]["username"], city: main.docs[index]["city"], image: main.docs[index]["image"], lat: main.docs[index]["lat"], lng: main.docs[index]["lng"], village: main.docs[index]["village"])
                          ),
                        ),
                        itemListOthersContainer(title: "", id: main.docs[index].id),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                          child: Divider(
                            thickness: 3,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }
          )
        ],
      ),
    );
  }
}

