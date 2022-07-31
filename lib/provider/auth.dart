import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Timer? _authTimer;
  bool _showForm = false;

  bool get isAuth {
    return token != null;
  }

  bool get showForm {
    return _showForm;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> authenticate1(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAqyk7TDClx0TBfEDpaQu0VVW-IPtSOIM4");
    try {
      final response = await http.post(
        url,
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}),
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData["error"]["message"]);
      }
      _token = responseData["idToken"];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData["expiresIn"]),
        ),
      );
      _autoLogout();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return authenticate1(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    await authenticate1(email, password, "signInWithPassword");
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters/$userId.json/?auth=$_token");

    final res = await http.get(url);
    final resData = json.decode(res.body);
    resData.forEach((renterId, renterData) {
      if (!renterData["admin"]) {
        _token = null;
        _userId = null;
        _expiryDate = null;
        throw HttpException("Not Valid Credentials");
      }
    });
    return;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> showAddItemForm() async {
    if (_token != null) {
      final url = Uri.parse(
          "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters/$_userId.json?auth=$_token");

      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData != null) {
        _showForm = false;
      } else {
        _showForm = true;
      }
    } else {
      _showForm = false;
    }
  }
}
