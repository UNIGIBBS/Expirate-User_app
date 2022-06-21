import 'package:comp2/services/map_utils.dart';
import 'package:comp2/widgets/stars.dart';
import 'package:flutter/material.dart';

import '../pages/others_page.dart';
import 'star.dart';

class MarketOverview extends StatefulWidget {
  MarketOverview({Key? key, required this.rate, required this.type, required this.name, required this.image, required this.city, required this.lat, required this.lng, required this.village}) : super(key: key);

  double rate;
  String type;
  var name;
  var image;
  var city;
  var lat;
  var lng;
  var village;
  @override
  _MarketOverviewState createState() => _MarketOverviewState();
}

class _MarketOverviewState extends State<MarketOverview> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Card(
          elevation: widget.type =="Search" || widget.type == "Map" ? 5 : 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: SizedBox(
            height: width/2+20,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        height: width/2*0.8,
                        width: width-20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(widget.image),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: (){
                            MapUtils.openMap(widget.lat, widget.lng);
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
                  ),
                ),
                Padding(
                  padding:widget.type != "Map" ? EdgeInsets.fromLTRB(16, 0, 10, 10) : EdgeInsets.fromLTRB(16, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: height*0.02,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
