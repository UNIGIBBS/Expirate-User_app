import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

enum PaymentOptions{cash, card}

class _PaymentPageState extends State<PaymentPage> {

  String cityDrop = "City";
  String villageDrop = "Village";
  String? selectedCity;
  String? selectedVillage;
  List<String> cities = ["Choose","Kayseri", "İstanbul", "Ankara", "İzmir"];
  List<String> villKayseri = ["Choose","Melikgazi", "Kocasinan"];
  List<String> villIstanbul = ["Choose","Bakırköy", "Beşiktaş", "Çatalca","Esenler", "Fatih", "Kadıköy"];
  List<String> villAnkara = ["Choose","Altındağ", "Çankaya", "Gölbaşı", "Sincan", "Yenimahalle"];
  List<String> villIzmir = ["Choose","Bornova", "Buca", "Çeşme", "Foça", "Karşıyaka"];

  late List<String> list =  ["Choose","Melikgazi", "Kocasinan","Bakırköy", "Beşiktaş", "Çatalca","Esenler", "Fatih", "Kadıköy",
    "Altındağ", "Çankaya", "Gölbaşı", "Sincan", "Yenimahalle","Bornova", "Buca", "Çeşme", "Foça", "Karşıyaka"];

  late List<String> listnew =  ["Choose","Melikgazi", "Kocasinan","Bakırköy", "Beşiktaş", "Çatalca","Esenler", "Fatih", "Kadıköy",
    "Altındağ", "Çankaya", "Gölbaşı", "Sincan", "Yenimahalle","Bornova", "Buca", "Çeşme", "Foça", "Karşıyaka"];


  PaymentOptions? paymentOptions = PaymentOptions.card;

  int chosenCard = 0;

  @override
  Widget build(BuildContext context) {


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffa1c6ea),
      ),
      bottomSheet: Container(
        height: height*0.07,
        color: Color(0xffa1c6ea),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.black,),
                      SizedBox(width: 5,),
                      Text("41.25", style: GoogleFonts.aBeeZee(color: Colors.black, fontWeight: FontWeight.bold, fontSize: height*0.017),)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, height*0.005, 0, height*0.005),
                child: Card(
                  color: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Colors.blueGrey, width: 3)
                  ),
                  child: Container(
                      height: height*0.06,
                      width: width/1.5,
                      child: Center(
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "Approve the Payment",
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height*0.035
                                ),
                              ),
                            ),
                          )
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 0, 0),
            child: Text("Delivery adress", style: TextStyle(fontWeight: FontWeight.bold, fontSize: height*0.017),),
          ),
          Divider(
            thickness: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 10,
                color: Color(0xffa1c6ea),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 2, 0),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 50,
                    dropdownColor: Colors.white,
                    value: selectedCity,
                    onChanged: (value){
                      setState((){
                        selectedCity = value.toString();
                        selectedVillage = "Choose";

                        if(selectedCity == "İstanbul") {
                          list = villIstanbul;
                        }
                        else if(selectedCity == "Kayseri"){
                          list = villKayseri;
                        }
                        else if(selectedCity == "İzmir"){
                          list = villIzmir;
                        }
                        else{
                          list = villAnkara;
                        }

                      });
                    },
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text("City", style: TextStyle(color: Colors.black),),
                    ),
                    items: cities.map((String name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(name),
                        ),);

                    }).toList(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 10,
                color: Color(0xffa1c6ea),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 2, 0),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 50,
                    dropdownColor: Colors.white,
                    value: selectedVillage,
                    onChanged: (value){
                      setState((){
                        selectedVillage = value.toString();
                      });
                    },
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text("Village", style: TextStyle(color: Colors.black),),
                    ),
                    items: list.map((String name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(name),
                        ),);

                    }).toList(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: width/2,
              width: width,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 3),
                ),
                elevation: 10,
                child: FlutterMap(
                  options: MapOptions(
                      center: LatLng(38.9637, 35.2433),
                      zoom: 8
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                        markers: [
                          Marker(point: LatLng(38.9637, 35.2433), builder: (context) => Icon(Icons.person_pin_circle_sharp, size: height*0.03, color: Colors.blue,)),
                        ]
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: height*0.02,
          ),
          Container(
            color: Colors.grey[350],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Payment options",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height*0.017
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 3, color: Colors.grey[200],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width/2.5,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: RadioListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            tileColor: paymentOptions != PaymentOptions.card ? Colors.grey[300] :Color(0xffa1c6ea),
                            title: Text("With card", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                            value: PaymentOptions.card,
                            groupValue: paymentOptions,
                            onChanged: (PaymentOptions? value){
                              setState(() {
                                paymentOptions = value!;
                              });                            }
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width/2.5,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: RadioListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            tileColor: paymentOptions != PaymentOptions.cash ? Colors.grey[300] :Color(0xffa1c6ea),
                            title: Text("By cash", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                            value: PaymentOptions.cash,
                            groupValue: paymentOptions,
                            onChanged: (PaymentOptions? value){
                              setState(() {
                                paymentOptions = value!;
                              });
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 3, color: Colors.grey[200],),
                paymentOptions == PaymentOptions.card ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                chosenCard = 1;
                              });
                              print(chosenCard);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey,width: 2, style: BorderStyle.solid)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(chosenCard != 1 ? Icons.circle : Icons.done, color : chosenCard != 1 ? Colors.white : Colors.black, size: height*0.022,),
                              ),
                            ),
                          ),

                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(width*0.1, 8, width*0.1, 8),
                              child: SizedBox(
                                  height: height*0.025,
                                  child: FittedBox(
                                    child: Text(
                                      "1234  5678  9123  4567",
                                      style: TextStyle(
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                chosenCard = 0;
                              });
                              print(chosenCard);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey,width: 2, style: BorderStyle.solid)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(chosenCard != 0 ? Icons.circle : Icons.done, color : chosenCard != 0 ? Colors.white : Colors.black, size: height*0.022,),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(width*0.1, 8, width*0.1, 8),
                              child: SizedBox(
                                  height: height*0.025,
                                  child: FittedBox(
                                    child: Text(
                                      "1234  5678  9123  4567",
                                      style: TextStyle(
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 3, color: Colors.grey[200],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 10,
                          color: Color(0xffa1c6ea),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                            child: Text(
                              "Add a new card",
                              style: TextStyle(
                                  fontSize: height*0.02,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 3, color: Colors.grey[200],)
                  ],
                ) : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
