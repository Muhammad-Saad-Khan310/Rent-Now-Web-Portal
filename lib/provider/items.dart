// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import './item.dart';

class Items with ChangeNotifier {
  List<Item> _items = [
    Item(
        id: "i1",
        title: "Car",
        price: "5000",
        imageUrl:
            "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg",
        description: "some description",
        address: "Peshawar",
        phoneNumber: "03144455"),
    Item(
        id: "i2",
        title: "Car",
        price: "5000",
        imageUrl:
            "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg",
        description: "some description",
        address: "Peshawar",
        phoneNumber: "03144455"),
    Item(
        id: "i3",
        title: "Car",
        price: "5000",
        imageUrl:
            "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg",
        description: "some description",
        address: "Peshawar",
        phoneNumber: "03144455"),
    Item(
        id: "i4",
        title: "Car",
        price: "5000",
        imageUrl:
            "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg",
        description: "some description",
        address: "Peshawar",
        phoneNumber: "03144455"),
    Item(
        id: "i5",
        title: "Honda Civic",
        price: "5000",
        imageUrl:
            "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg",
        description: "some description",
        address: "Peshawar",
        phoneNumber: "03144455")
  ];

  final String authToken;
  Items(this.authToken);

  List<Item> get items {
    return [..._items];
  }

  Item findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> fetchAndSetItems([bool filterByUser = false]) async {
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/items.json");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<Item> loadedItem = [];

      extractedData.forEach((itemId, itemData) {
        if (!itemData["validItem"]) {
          loadedItem.insert(
              0,
              Item(
                id: itemId,
                title: itemData['title'],
                description: itemData['description'],
                phoneNumber: itemData['phoneNumber'],
                imageUrl: itemData['imageUrl'],
                price: itemData['price'],
                address: itemData['address'],
              ));
        }
      });

      _items = loadedItem;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> acceptItem(String id) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          "https://rentnow-f12ca-default-rtdb.firebaseio.com/items/$id.json?auth=$authToken");
      http.patch(url,
          body: json.encode({
            'validItem': true,
          }));
      _items.removeAt(prodIndex);
      notifyListeners();
    } else {
      print("product with that id not exsit");
    }
  }

  Future<void> deleteItem(String id) async {
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/items/$id.json?auth=$authToken");

    final existingItemIndex = _items.indexWhere((item) => item.id == id);
    Item? existingItem = _items[existingItemIndex];
    _items.removeAt(existingItemIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingItemIndex, existingItem);
      notifyListeners();
      throw HttpException("Could not delete Item.");
    }
    existingItem = null;
  }
}
