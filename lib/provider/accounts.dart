import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class Account {
  final String id;
  final String userName;
  final String imageUrl;
  final String address;
  final String dateOfBirth;
  final String phoneNumber;

  Account(
      {required this.id,
      required this.userName,
      required this.imageUrl,
      required this.dateOfBirth,
      required this.address,
      required this.phoneNumber});
}

class UserAccounts with ChangeNotifier {
  final String userId;
  final String authToken;
  // Map<String, String> mpp = {"userName": "", 'imageUrl': ""};
  UserAccounts(this.userId, this.authToken, this._accounts);
  List<Account> _accounts = [
    // Account(
    //     id: "u1",
    //     userName: "Ahmed Khan",
    //     dateOfBirth: "10/12/2000",
    //     imageUrl:
    //         "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg",
    //     address: "Peshawar",
    //     phoneNumber: "031444555"),
    // Account(
    //     id: "u2",
    //     userName: "Ahmed Khan",
    //     dateOfBirth: "10/12/2000",
    //     imageUrl:
    //         "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg",
    //     address: "Peshawar",
    //     phoneNumber: "031444555"),
    // Account(
    //     id: "u3",
    //     userName: "Ahmed Khan",
    //     dateOfBirth: "10/12/2000",
    //     imageUrl:
    //         "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg",
    //     address: "Peshawar",
    //     phoneNumber: "031444555"),
    // Account(
    //     id: "u4",
    //     userName: "Ahmed Khan",
    //     dateOfBirth: "10/12/2000",
    //     imageUrl:
    //         "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg",
    //     address: "Peshawar",
    //     phoneNumber: "031444555"),
    // Account(
    //     id: "u5",
    //     userName: "Sad",
    //     dateOfBirth: "10/12/2000",
    //     imageUrl:
    //         "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg",
    //     address: "Peshawar",
    //     phoneNumber: "031444555"),
  ];

  List<Account> get accounts {
    return [..._accounts];
  }

  Account findById(String id) {
    return _accounts.firstWhere((item) => item.id == id);
  }

  // Future<void> fetchAndSetAccounts([bool filterByUser = false]) async {
  //   // final filterString = filterByUser
  //   //     ? '?auth=$authToken&orderBy="creatorId"&equalTo="$userId"'
  //   //     : '';
  //   // final url = Uri.parse(
  //   //     "https://rentnow-f12ca-default-rtdb.firebaseio.com/items.json$filterString");
  //   final url = Uri.parse(
  //       "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters.json");
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     List<Account> loadedItem = [];
  //     // print("++++++++=");
  //     // print(extractedData);

  //     extractedData.forEach((itemId, itemData) {
  //       print("______++++______");
  //       print(itemData);
  //       // mpp = {
  //       //   "userName": itemData['userName'],
  //       //   "imageUrl": itemData['imageUrl']
  //       // };
  //       loadedItem.insert(
  //           0,
  //           Account(
  //             id: itemId,
  //             userName: itemData['userName'],
  //             dateOfBirth: itemData['dateOfBirth'],
  //             phoneNumber: itemData['phoneNumber'],
  //             imageUrl: itemData['imageUrl'],
  //             address: itemData['address'],
  //           ));
  //     });
  //     // if (filterByUser) {
  //     //   _userItems = loadedItem;
  //     // } else {
  //     //   _items = loadedItem;
  //     // }
  //     _accounts = loadedItem;

  //     notifyListeners();
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<void> fetchRenter() async {
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters/$userId.json/?auth=$authToken");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      List<Account> loadedItem = [];

      extractedData.forEach((itemId, itemData) {
        loadedItem.insert(
            0,
            Account(
              id: itemId,
              userName: itemData['userName'],
              dateOfBirth: itemData['dateOfBirth'],
              phoneNumber: itemData['phoneNumber'],
              imageUrl: itemData['imageUrl'],
              address: itemData['address'],
            ));
      });

      _accounts = loadedItem;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getUserProfile() async {
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters/$userId.json?auth=$authToken");
    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    List<Account> loadedItem = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((renterId, renterData) {
      loadedItem.insert(
        0,
        Account(
            id: renterId,
            userName: renterData['userName'],
            dateOfBirth: renterData['dateOfBirth'],
            phoneNumber: renterData['phoneNumber'],
            address: renterData['address'],
            imageUrl: renterData['imageUrl']),
      );
    });
    _accounts = loadedItem;
    notifyListeners();
  }

  Future<void> updateAdmin(String id, Account newData) async {
    final prodIndex = _accounts.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters/$userId/$id.json?auth=$authToken");
      http.patch(url,
          body: json.encode({
            'userName': newData.userName,
            'imageUrl': newData.imageUrl,
            'dateOfBirth': newData.dateOfBirth,
            'phoneNumber': newData.phoneNumber,
            'address': newData.address,
          }));
      _accounts[prodIndex] = newData;
      notifyListeners();
    } else {
      print("product with that id not exsit");
    }
  }

  void deleteItem(String id) {
    _accounts.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
