import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp2/providers/product_list.dart';
import 'package:comp2/providers/shopping_list_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/list_model.dart';

class editButton extends StatefulWidget {
  editButton({Key? key, required this.productInfo}) : super(key: key);

  var productInfo;
  @override
  State<editButton> createState() => _editButtonState();
}

class _editButtonState extends State<editButton> {

  var theChosenOne = 0;

  List? list;

  @override
  void initState() {
    super.initState();
    getData();
  }

  var data;

  getData() async{
    print(FirebaseAuth.instance.currentUser?.uid);
    await FirebaseFirestore.instance.collection("Shopping list").doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      list = [];
      value.get("lists").forEach((value) {
        print("aaa");
        print(value);
        list?.add({
          "title": value["title"],
          "date": value["date"],
          "products": value["products"]
        });
      });
    }
    );
  }

  TextEditingController listNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Positioned(
      top: 12,
      right: 12,
      child: SizedBox(
        height: 27,
        width: 27,
        child: FloatingActionButton(
          heroTag: null,
          shape: RoundedRectangleBorder(
            side:  BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.white,
          mini: true,
          // foregroundColor: customBlue,
          onPressed: () {
            list != null ? showDialog(
                context: context,
                builder: (context){
                  var open = false;

                  return Consumer<ShoppingListProvider>(
                    builder: (context, shopList, child) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Add product"),
                              GestureDetector(
                                onTap: (){
                                  shopList.addOpenFalse();
                                },
                                child: Container(
                                  width: width * 0.1,
                                  height: width * 0.1,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Icon(
                                        shopList.open != true ? Icons.add : Icons.delete,
                                        color: Colors.white,
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                          content: Column(
                            children: [
                              shopList.open == true ? Column(
                                children: [
                                  TextField(
                                    controller: listNameController,
                                    decoration: InputDecoration(
                                      hintText: "List name..."
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                                        onPressed: (){
                                          if(list!=null){
                                            list?.add({"title": listNameController.text, "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}","products":[]});
                                            FirebaseFirestore.instance.collection("Shopping list").doc(FirebaseAuth.instance.currentUser?.uid).set({
                                              "lists":list
                                            });
                                          }
                                        },
                                        child: Text("Create")
                                    ),
                                  ),
                                ],
                              ) : Container(),
                              SizedBox(
                                height: height / 3,
                                width: width-20,
                                child: ListView.builder(
                                  itemCount: list?.length,
                                  itemBuilder: (context, index){
                                    return Column(
                                      children: [
                                        ShopListAlertWidget(list: list![index]),
                                        Divider(
                                          color: Colors.grey[300],
                                          thickness: 2,
                                          endIndent: width/5,
                                          indent: width/5,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                            ),
                        SizedBox(
                          width: width*0.8,
                          child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                              onPressed: ()async{
                                var newList;
                                await FirebaseFirestore.instance.collection("Shopping list").doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
                                  newList = [];
                                  value.get("lists").forEach((value) {
                                    newList?.add({
                                      "title": value["title"],
                                      "date": value["date"],
                                      "products": value["products"]
                                    });
                                  });
                                }
                                );
                                var shop;
                                newList?.forEach((element) {
                                  if(element["title"]==shopList.theChosenOne){
                                    shop = element;
                                    print("aaa");
                                    print(element);
                                  }
                                });
                                print("product");
                                print(shop);
                                print(shop?["products"]);
                                newList?.remove(shop);
                                print("List");

                                print(newList);
                                List listt = shop?["products"];
                                print("Listt");
                                print(listt);
                                print(widget.productInfo);
                                listt.add(widget.productInfo);
                                print("checker");
                                print(listt);
                                shop["products"] = listt;
                                print(shop);
                                print(newList!.length);
                                newList?.add(shop);
                                print("main");
                                print(newList);
                                
                                await FirebaseFirestore.instance.collection("Shopping list").doc(FirebaseAuth.instance.currentUser?.uid).set({
                                      "lists": newList
                                    }
                                    );
                                setState((){});
                              },
                              child: Text(
                                  "Add",
                                style: TextStyle(
                                  fontSize: height*0.02,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  );
                }).then((value) => Provider.of<ShoppingListProvider>(context, listen: false).deleteTheChosen()) : print("list not ready");
          },
          child: Icon(
            Icons.add, color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class ShopListAlertWidget extends StatelessWidget {
  ShopListAlertWidget({
    Key? key,
    required this.list
  }) : super(key: key);

  Map list;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Consumer<ShoppingListProvider>(
      builder: (context, shopList, child) => Container(
        width: width - 20,
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(list["title"]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: GestureDetector(
                    onTap: () {
                      shopList.changeTheChosen(list["title"]);
                    },
                    child: Container(
                      width: width * 0.06,
                      height: width * 0.06,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(2),
                          border: Border.all(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: shopList.theChosenOne == list["title"]
                          ? FittedBox(
                              child: Icon(
                                Icons.done,
                                color: Colors.red,
                              ),
                            )
                          : Container(),
                    ),
                  ),
                )
              ],
            )
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Colors.grey,
                width: 1,
                style: BorderStyle.solid)),
      ),
    );
  }
}
