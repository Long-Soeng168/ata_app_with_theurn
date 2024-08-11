import 'package:ata_app/models/product.dart';
import 'package:flutter/material.dart';

class Favorite extends ChangeNotifier {

  // User Favorites
  List<Product> _favorite = [];

  // Get User Favorite
  List<Product> get favorite => _favorite;

  // Add Item to Favorite
  void addToFavorite(Product item) {
    _favorite.add(item);
    notifyListeners();
  }

  // Remove Item from Favorite
  void removeFromFavorite(Product item) {
    _favorite.remove(item);
    notifyListeners();
  }
}
