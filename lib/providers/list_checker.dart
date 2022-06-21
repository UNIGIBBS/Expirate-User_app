import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListChecker with ChangeNotifier{
  bool value = false;

  changeValue(){
    value = true;
    notifyListeners();
  }

  zero(){
    value = false;
    notifyListeners();
  }
}