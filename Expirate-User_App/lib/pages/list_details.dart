

import 'package:comp2/pages/market_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListDetails extends StatefulWidget {
  const ListDetails({Key? key, required this.theList}) : super(key: key);
  final theList;

  @override
  State<ListDetails> createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.theList["title"], style: TextStyle(color: Colors.grey[900]),),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: widget.theList["products"].length,
        itemBuilder: (context, index){
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
                                            image: NetworkImage(widget.theList["products"][index]["image"]),
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
                                    widget.theList["products"][index]["title"],
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
                                              text: "Price: ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height*0.02,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            TextSpan(
                                              text: widget.theList["products"][index]["price"],
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
                                              text: "${widget.theList["products"][index]["expiry date"].toDate().day}/${widget.theList["products"][index]["expiry date"].toDate().month}/${widget.theList["products"][index]["expiry date"].toDate().year}",
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
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MarketPage(id: widget.theList["products"][index]["market"])));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.redAccent, style: BorderStyle.solid,width: 2)
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: const Icon(Icons.location_on, color: Colors.redAccent,)
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
