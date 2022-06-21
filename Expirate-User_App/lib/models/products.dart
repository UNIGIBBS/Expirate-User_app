import 'package:comp2/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class Products with ChangeNotifier{
  bool filtered = false;
  bool sorted = false;
  List<ProductModel> filteredItems = [];
  List<ProductModel> sortedItems = [];
  final List<ProductModel> _items = [
    
  ];
  filterList(filteredProduct) {
    filtered = true;
    filteredItems = [..._items];
    filteredItems.retainWhere((element) {
      return element.category!.contains(filteredProduct);
    });
    notifyListeners();
  }
  filterSorted(filteredProduct) {
    sorted = true;
    sortedItems = [..._items];
    sortedItems.retainWhere((element) {
      return element.category!.contains(filteredProduct);
    });
    notifyListeners();
  }


  updateList(product) {
    _items.add(product);
    notifyListeners();
  }
}