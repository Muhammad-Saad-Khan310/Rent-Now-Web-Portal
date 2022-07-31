// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:convert';

class ReportItem {
  final String reportId;
  final String imageUrl;
  final String reportMessage;
  final String itemOwnerEmail;
  final String itemId;

  ReportItem(
      {required this.reportId,
      required this.imageUrl,
      required this.reportMessage,
      required this.itemId,
      required this.itemOwnerEmail});
}

class ReportItems with ChangeNotifier {
  List<ReportItem> _reportItems = [];

  final String authToken;
  ReportItems(this.authToken);

  List<ReportItem> get reportItems {
    return [..._reportItems];
  }

  Future<void> fetchAndSetReport() async {
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/ReportItems.json");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      List<ReportItem> loadedItem = [];

      extractedData.forEach((itemId, itemData) {
        loadedItem.insert(
            0,
            ReportItem(
                reportId: itemId,
                imageUrl: itemData['itemImage'],
                reportMessage: itemData['itemReport'],
                itemId: itemData["itemId"],
                itemOwnerEmail: itemData["itemOwnerEmail"]));
      });
      _reportItems = loadedItem;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteReportItem(String itemId, String reportId) async {
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/items/$itemId.json?auth=$authToken");

    final url1 = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/ReportItems/$reportId.json?auth=$authToken");

    await http.delete(url1);

    final existingItemIndex =
        _reportItems.indexWhere((item) => item.itemId == itemId);
    ReportItem? existingItem = _reportItems[existingItemIndex];
    _reportItems.removeAt(existingItemIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _reportItems.insert(existingItemIndex, existingItem);
      notifyListeners();
      throw HttpException("Could not delete Item.");
    }
    existingItem = null;
  }

  Future<void> sendEmail(String image, String itemOwnerEmail, String message,
      String subject) async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': "service_vpp6u1s",
          'template_id': "template_s8zux4f",
          "user_id": "Msm-m4IikAR-UrBDD",
          'template_params': {
            'to_email': itemOwnerEmail,
            'user_subject': subject,
            'user_message': message,
            'item_image': image,
          }
        }));
    if (response.statusCode >= 400) {
      throw HttpException("Email is not send successfully but item is deleted");
    }
  }
}
