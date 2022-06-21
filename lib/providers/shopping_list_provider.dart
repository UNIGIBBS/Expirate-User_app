import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingListProvider with ChangeNotifier{
  var theChosenOne = "";

  var open = false;

  changeTheChosen(var num){
    theChosenOne = num;
    notifyListeners();
  }

  deleteTheChosen(){
    theChosenOne = "";
    notifyListeners();
  }

  addOpenFalse(){
    open = !open;
    notifyListeners();
  }
}