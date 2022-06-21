import 'package:comp2/models/product_model.dart';

class ShopList{
  String? title;
  String? date;
  ShopList({required this.title, required this.date, required this.products});
  List<Map> products = [];
}