

import 'package:comp2/widgets/basket_icon.dart';
import 'package:comp2/widgets/divider.dart';
import 'package:comp2/widgets/item_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';


import '../widgets/counter.dart';
import '../widgets/decoration.dart';
import 'home_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

bool _isFavorite = false;

class _DetailPageState extends State<DetailPage> {
  bool descIsOpen = false;

  String cityDrop = "Choose";
  String villageDrop = "Choose";

  Position? myCurrentLocation;

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    } else {
      print("serviceEnabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    } else {
      print("permission not denied");
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else {
      print("not denied forever");
    }

    Position sth = await Geolocator.getCurrentPosition();

    setState(() async {
      myCurrentLocation = sth;
    });
  }

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }
  double _value = 500;


  @override
  Widget build(BuildContext context) {
    print("I might be null$myCurrentLocation");


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var currentTime = DateTime.now();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.keyboard_backspace),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    color: Colors.black,
                    alignment: Alignment.centerLeft,
                  ),
                  basket_icon(),
                  // DateWidget(currentDay: currentTime.day, currentMonth: currentTime.month, currentYear: currentTime.year)
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Center(
              child: Stack(
                clipBehavior: Clip.none, 
                children: [
                  item_pic(height: height * 2, width: width * 2),
                  Positioned(
                    top: -35,
                    right: -25,
                    child: Container(
                      width: width * 0.13,
                      height: height * 0.13,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: .8,
                            offset: Offset(.0, 1.5),
                          ),
                        ],
                      ),
                      child: IconButton(
                        //color: color,
                        constraints: BoxConstraints(maxHeight: 35, maxWidth: 35),
                        onPressed: () async {
                          print(_isFavorite);
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                          print(_isFavorite);
                        },
                        iconSize: 20,
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,15,0,10),
                  child: counter(space: 15, size: 30,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Pinar milk 20%",
                  textAlign: TextAlign.center,
                  style: style_arguments(
                      Colors.black.withOpacity(0.6), FontWeight.w800, height * 0.025, 'OpenSans')),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "20% Off"
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),

                    RichText(
                      text: TextSpan(
                        /*style: style_arguments(Colors.black, FontWeight.w600,
                              height * 0.022, 'OpenSans'),*/
                          style: style_arguments(Colors.redAccent[400],
                              FontWeight.bold, height * 0.028, 'OpenSans'),
                          children: [
                            TextSpan(
                              text: "10.99 ",
                            ),
                            TextSpan(
                              text: "\$",
                              /*style: style_arguments(Colors.black,
                                    FontWeight.w600, height * 0.022, 'OpenSans'))*/
                              style: style_arguments(Colors.redAccent[400],
                                  FontWeight.bold, height * 0.028, 'OpenSans'),
                            ),]),
                    ),
                  ],
                ),
              ),
            ),

            divider(color: Colors.black54.withOpacity(0.2)),
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(

                title: Card(
                  elevation: 5,
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Description",
                        style: style_arguments(Colors.black.withOpacity(0.6),
                            FontWeight.w600, height * 0.022, 'OpenSans')),
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: width,
                          child: Text(
                              "DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription",
                              style: style_arguments(Colors.black,
                                  FontWeight.w400, height * 0.02, 'OpenSans')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*Padding(
              padding:
                  EdgeInsets.fromLTRB(width / 5, height * 0.01, width / 5, 0),
              child: divider(
                color: Colors.black54.withOpacity(0.2),
              ),
            ),
            Center(
              child: Text("Check around you!",
                  style: style_arguments(
                      Colors.black, FontWeight.w600, height * 0.022, 'OpenSans')),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * 0.3,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    elevation: 5,
                    color: Color(0xfffe5c5c),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 2, 0),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10.0),
                        value: cityDrop,
                        items: <String>[
                          'Choose',
                          'Istanbul',
                          'Ankara',
                          'Izmir',
                          'Bursa'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: style_arguments(Colors.white,
                                  FontWeight.w800, height * 0.021, 'OpenSans'),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            cityDrop = value.toString();
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    elevation: 5,
                    color: Color(0xfffe5d5d),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 2, 0),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10.0),
                        value: villageDrop,
                        items: <String>[
                          'Choose',
                          'Kocasinan',
                          'Smt',
                          'SMth',
                          'ssss'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: style_arguments(Colors.white,
                                    FontWeight.w800, height * 0.021, 'OpenSans')),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            villageDrop = value.toString();
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(width / 5, height * 0.01, width / 5, 0),
              child: divider(
                color: Colors.black54.withOpacity(0.2),
              ),
            ),*/
            divider(color: Colors.black54.withOpacity(0.2)),

            Padding(
              padding: const EdgeInsets.fromLTRB(10,0,10,0),
              child: Row(
                children: [
                  Text("Choose Distance", style: style_arguments(Colors.black.withOpacity(0.8), FontWeight.bold, height*0.023, 'Open Sans'),),
                  Spacer(),
                  Text(_value.toInt().toString() + "m", style: style_arguments(Colors.black.withOpacity(0.8), FontWeight.bold, height*0.023, 'Open Sans'),),
                ],
              ),
            ),

            SfSlider(
              min: 0.0,
              max: 1000.0,
              value: _value,
              interval: 200,
              showTicks: true,
              showLabels: false,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              //thumbIcon: Icon(Icons.add_location_outlined, color: Colors.white,),
              onChanged: (dynamic value){
                setState(() {
                  _value = value;
                });
              },
            ),
            SizedBox(
              height: width / 2,
              width: width,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.grey, style: BorderStyle.solid, width: 2),
                ),
                elevation: 10,
                child: FutureBuilder(
                    future: _determinePosition(),
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return FlutterMap(
                          options: MapOptions(
                              center: LatLng(
                                  myCurrentLocation == null
                                      ? 38.9637
                                      : myCurrentLocation!.latitude,
                                  myCurrentLocation == null
                                      ? 35.2433
                                      : myCurrentLocation!.longitude),
                              zoom: 8),
                          layers: [
                            TileLayerOptions(
                              urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'],
                            ),
                            MarkerLayerOptions(markers: [
                              Marker(
                                  point: LatLng(38.9637, 35.2433),
                                  builder: (context) => Icon(
                                    Icons.person_pin_circle_sharp,
                                    size: height * 0.03,
                                    color: Colors.blue,
                                  )),
                            ])
                          ],
                        );
                      }
                    }),
              ),
            ),
            /*Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PaymentPage()));
                  },
                  icon: Icon(Icons.done)),
            ),*/
          ],
        ),
      ),
    );
  }
}
