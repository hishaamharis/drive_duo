import 'package:flutter/material.dart';

import '../model/carModel.dart';

class FavouriteProvider with ChangeNotifier {
  List<Car> _favouriteCars = [];

  List<Car> get favouriteCars => _favouriteCars;

  void addCarToFavourites(Car car) {
    _favouriteCars.add(car);
    notifyListeners();
  }

  void removeCarFromFavourites(Car car) {
    _favouriteCars.remove(car);
    notifyListeners();
  }

  bool isFavourite(Car car) {
    return _favouriteCars.contains(car);
  }
}
