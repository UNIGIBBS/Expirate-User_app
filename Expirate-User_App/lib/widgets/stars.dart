import 'package:flutter/material.dart';

import 'star.dart';

class Stars extends StatefulWidget {
  Stars({Key? key, required this.rate}) : super(key: key);

  double rate;

  @override
  _StarsState createState() => _StarsState();
}

class _StarsState extends State<Stars> {

  List<double> staredUp = [0,0,0,0,0];

  starUp(double rate){
    int intRate = rate.floor();

    for(int i = 0; i<5; i++){
      if(i<intRate){
        staredUp[i] = 1;
      }else if(i==intRate){
        if(rate-intRate<0.5){
          staredUp[i] = 0;
        }else{
          staredUp[i] = 0.5;
        }
      }else{
        staredUp[i] = 0;
      }
    }
  }

  @override
  void initState() {
    starUp(widget.rate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.all(0.0),
            child: Star(form: staredUp[0],)
        ),
        Padding(
            padding: const EdgeInsets.all(0.0),
            child: Star(form: staredUp[1],)
        ),
        Padding(
            padding: const EdgeInsets.all(0.0),
            child: Star(form: staredUp[2],)
        ),
        Padding(
            padding: const EdgeInsets.all(0.0),
            child: Star(form: staredUp[3],)
        ),
        Padding(
            padding: const EdgeInsets.all(0.0),
            child: Star(form: staredUp[4],)
        ),
      ],
    );
  }
}
