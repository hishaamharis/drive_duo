import 'package:flutter/material.dart';

import '../model/carModel.dart';

class CartProvider with ChangeNotifier {
  List<Car> _cartItems = [];

  List<Car> get cartItems => _cartItems;

  void addCarToCart(Car car) {
    _cartItems.add(car);
    notifyListeners();
  }

  void removeCarFromCart(Car car) {
    _cartItems.remove(car);
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0.0, (sum, car) => sum + car.pricePerDay);
  }

  int get itemCount {
    return _cartItems.length;
  }
}
