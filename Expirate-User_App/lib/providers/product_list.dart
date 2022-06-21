import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList with ChangeNotifier{
  List<Widget> productList = [

  ];

  updateList(Widget widget){
    productList.add(widget);
    notifyListeners();
  }

  emptyList(){
    productList = [];
  }
}