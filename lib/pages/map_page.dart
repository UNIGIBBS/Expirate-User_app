import 'package:comp2/models/user_location_model.dart';
import 'package:comp2/pages/favorite_page.dart';
import 'package:comp2/widgets/favorite_button.dart';
import 'package:comp2/widgets/filter_button.dart';
import 'package:comp2/widgets/item_list_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'dart:math' show cos, sqrt, asin;

import '../models/user_model.dart';
import '../widgets/market_overview.dart';
import 'filter_page.dart';
import 'market_page.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  List<LatLng> listOfCoordinates = [LatLng(38.9637, 35.2433), LatLng(38.9, 35.243)];

  double calculateDistance(LatLng latLng1, LatLng latLng2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((latLng2.latitude - latLng1.latitude) * p)/2 +
        c(latLng1.latitude * p) * c(latLng2.latitude * p) *
            (1 - c((latLng2.longitude - latLng1.longitude) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  double zoomValue = 8;
  MapController mapController = MapController();

  double sliderValue = 500;

  @override
  Widget build(BuildContext context) {

    var userLocation = Provider.of<UserLocation?>(context);
    print(userLocation);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print(calculateDistance(listOfCoordinates[0], listOfCoordinates[1]));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Search around you"),
      ),
      body: Stack(
        children: [
          userLocation != null ? FlutterMap(
            mapController: mapController,
            options: MapOptions(
                center: LatLng(userLocation!.latitude!, userLocation!.longitude!),
                zoom: zoomValue
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                  markers: [
                    Marker(
                        point: LatLng(userLocation.latitude!, userLocation.longitude!),
                        builder: (context) => IconButton(
                          icon: Icon(Icons.person_pin_circle_sharp),
                          iconSize: height*0.03,
                          color: Colors.red,
                          onPressed: (){
                          },
                        )
                    ),
                    Marker(
                        point: listOfCoordinates[1],
                        builder: (context) => IconButton(
                          icon: Icon(Icons.person_pin_circle_sharp),
                          iconSize: height*0.03,
                          color: Colors.blue,
                          onPressed: (){
                            showBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    )
                                ),
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) => Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )
                                  ),
                                  height: height/2,
                                  child: Stack(
                                    children: [
                                      ListView(
                                        children: [
                                          SizedBox(
                                              width: width,
                                              child: FittedBox(
                                                  // child: MarketOverview(rate: 3.7, type: "Map")
                                              )
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
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
                                          ),
                                          ElevatedButton(
                                            onPressed: (){
                                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MarketPage()));
                                            },
                                            child: Text("Open"),
                                          )
                                        ],
                                      ),
                                      Positioned(
                                        top: 15,
                                        left: 15,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black87,
                                          radius: 25,
                                          child: IconButton(

                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.clear,color: Colors.white,),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            );
                          },
                        )
                    ),                  ]
              )
            ],
          ) : Container(),
          Positioned(
            right: 10,
            bottom: 10,
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 10,
                  child: Center(
                    child: SizedBox(
                      height: height/2,
                      width: width*0.11,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          label: sliderValue.toInt().toString(),
                          onChangeEnd: (value){

                          },
                          activeColor: Colors.redAccent[400],
                          inactiveColor: Colors.redAccent[400]!.withOpacity(0.4),
                          onChanged: (value){
                            setState(() {
                              sliderValue = value;
                            });
                          },
                          value: sliderValue,
                          max: 2100,
                          min: 100,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap:(){
                    setState(() {
                      zoomValue++;
                    });
                    print(mapController.center);
                    mapController.move(mapController.center, zoomValue);
                    print(zoomValue);
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: SizedBox(
                      width: width*0.11,
                      height: width*0.11,
                      child: Icon(Icons.zoom_in),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap:(){
                    setState(() {
                      zoomValue--;
                    });
                    mapController.move(mapController.center, zoomValue);
                    print("Pressed");
                    print("$zoomValue");
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: SizedBox(
                      width: width*0.11,
                      height: width*0.11,
                      child: Icon(Icons.zoom_out),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 4,
            left: 4,
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: SizedBox(
                    height: width*0.11,
                    width: width-8,
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(style: BorderStyle.none, width: 0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(style: BorderStyle.none, width: 0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(style: BorderStyle.none, width: 0),
                            ),
                            hintText: "Search markets..."
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: SizedBox(
                          height: width*0.11,
                          width: width*0.11,
                          child: Center(
                            child: Icon(Icons.tune),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
