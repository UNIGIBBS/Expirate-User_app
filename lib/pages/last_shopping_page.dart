import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp2/models/list_model.dart';
import 'package:comp2/models/product_model.dart';
import 'package:comp2/pages/list_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile.dart';
import '../widgets/basket_icon.dart';
import '../widgets/chart.dart';
import '../widgets/counter.dart';
import '../widgets/decoration.dart';
import '../widgets/divider.dart';
import '../widgets/graph_info.dart';
import '../widgets/item_pic.dart';
import 'home_page.dart';

const Color customBackground = Color(0xffe6e6ec);

void main() => runApp(lastShopping());

class lastShopping extends StatefulWidget {
  const lastShopping({Key? key}) : super(key: key);

  @override
  State<lastShopping> createState() => _lastShoppingState();
}

class _lastShoppingState extends State<lastShopping> {
  TextEditingController listController = TextEditingController();

  List? list;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    print(FirebaseAuth.instance.currentUser?.uid);
    await FirebaseFirestore.instance.collection("Shopping list").doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      print(value.get("lists"));
      list = [];
      value.get("lists").forEach((value) {
        print(value);
        List<Map<dynamic, dynamic>> mapList = [];
        print(value["products"]);
        list?.add({
          "title": value["title"],
          "date": value["date"],
          "products": value["products"]
        });
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: (){
          FocusScopeNode focusScopeNode = FocusScope.of(context);
          if(!focusScopeNode.hasPrimaryFocus){
            focusScopeNode.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                Text('My List',
                    style: style_arguments(
                        Colors.black, FontWeight.w500, height * 0.03, 'OpenSans')),
                divider(color: Colors.black54),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "New list",
                              style: TextStyle(
                                  fontSize: height*0.025,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: (){
                                      if(list!=null && listController.text != ""){
                                        list?.add({
                                          "title": listController.text, "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}","products":[]
                                        });

                                        FirebaseFirestore.instance.collection("Shopping list").doc(FirebaseAuth.instance.currentUser?.uid).set({
                                          "lists":list
                                        });
                                        FocusScopeNode focusScopeNode = FocusScope.of(context);
                                        if(!focusScopeNode.hasPrimaryFocus){
                                          focusScopeNode.unfocus();
                                        }
                                        listController.text = "";
                                        setState((){

                                        });
                                      }
                                    },
                                    icon: Icon(Icons.done_outline, color: Colors.red, size: height*0.03,)
                                ),
                                IconButton(
                                    onPressed: (){
                                      FocusScopeNode focusScopeNode = FocusScope.of(context);
                                      if(!focusScopeNode.hasPrimaryFocus){
                                        focusScopeNode.unfocus();
                                      }
                                      listController.text = "";
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red[950], size: height*0.03,)
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: TextField(
                          controller: listController,
                          decoration: InputDecoration(
                              hintText: "List name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey, width: 2, style: BorderStyle.solid)
                              )
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                          child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Date: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: height*0.02,
                                          color: Colors.black
                                      )
                                  ),
                                  TextSpan(
                                      text: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey[700],
                                          fontSize: height*0.02
                                      )
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }else{
                        return MyStatefulWidget(list: list);
                      }
                    },
                  )
              ),
              SizedBox(height: height*0.1,)
            ],
          ),
        ),
      ),
    );
  }
}


class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key, required this.list}) : super(key: key);
  var list;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  var currentItem = itemList.getData;
  int? _currIndex;
  
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.list.length == 7?1:widget.list.length,
      itemBuilder: (context, index){
        print("onBuild");
        print(widget.list[index]["products"]);
        return ShoppingList(title: widget.list[index]["title"], date: widget.list[index]["date"], data: widget.list[index]);
      },
    );
  }
}

class ShoppingList extends StatelessWidget {
  const ShoppingList({
    Key? key,
    required this.title,
    required this.date,
    required this.data,
  }) : super(key: key);

  final title;
  final date;
  final data;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8,10, 8, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(title,
                            style: style_arguments(
                                Colors.black,
                                FontWeight.w600,
                                height * 0.021,
                                'OpenSans')),
                        Icon(CupertinoIcons.shopping_cart)
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListDetails(theList: data)));
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width/2.5,
                        height: width/2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: NetworkImage("https://www.jonesandcane.co.uk/wp-content/uploads/2016/02/American-grocery-bag.jpg"),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                        child: Text(
                          "At: ${date}",
                          style: style_arguments(
                              Colors.black,
                              FontWeight.w600,
                              height * 0.021,
                              'OpenSans'),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Chart(
                        graphInformation: [
                          GraphInfo("Total spend", 120),
                          GraphInfo("Total saved", 40),
                          // GraphInfo("Total spend", 120),
                        ],
                        maxValue: 160
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class itemList {
  static final getData = [
    {
      'name': 'name1 name1 name1 name1 name1name1name1',
      'thumbnail': 'thumbnail1',
      'brand': 'brand1',
      'amount': 'amount1',
      'price': '56.90',
    },
    {
      'name': 'name2',
      'thumbnail': 'thumbnail2',
      'brand': 'brand2',
      'amount': 'amount2',
      'price': '56.90',
    },
    {
      'name': 'name3name3name3name3',
      'thumbnail': 'thumbnail3',
      'brand': 'brand3',
      'amount': 'amount2',
      'price': '56.90',
    },
  ];
}
