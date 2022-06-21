import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier{
  late String? name;
  late String? url;
  late String? category;
  late String? brand;
  late String? marketBrand;
  late String? price;
  late Timestamp? date;


  ProductModel({
    this.name,
    this.url,
    this.category,
    this.brand,
    this.marketBrand,
    this.price,
    this.date
});
}
