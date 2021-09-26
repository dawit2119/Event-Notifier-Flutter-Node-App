import 'dart:convert';

import 'package:frontend/Utilities/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Models/SubscriptionModel.dart';

class SubscriptionDataProvider {
  static Future<dynamic> subscribe(SubscriptionModel subsModel) async {
    var message;
    try {
      final response = await http.post(Uri.parse('$API_URL/subscribe'),
          body: subsModel.toJson());
      if (response.statusCode == 201) {
        message = jsonDecode(response.body);
        print(message);
      } else {
        message = "Failed to subscribe";
        print(message);
      }
    } catch (e) {
      message = e.toString();
    }
    return message;
  }

  static Future<dynamic> unSubscribe(SubscriptionModel subsModel) async {
    dynamic message;
    try {
      final response = await http.post(Uri.parse('$API_URL/unsubscribe'),
          body: subsModel.toJson());
      if (response.statusCode == 201) {
        message = jsonDecode(response.body);
        print(message);
      } else {
        message = "Failed to unsubscribe";
        print(message);
      }
    } catch (e) {
      message = e.toString();
    }
    return message;
  }

  static Future<List<dynamic>> getAllSubscriptions(String id) async {
    dynamic allsubscriptions;
    try {
      final response =
          await http.get(Uri.parse('$API_URL/getallsubscriptions/$id'));
      print("sub repository passed");

      if (response.statusCode == 200) {
        allsubscriptions = jsonDecode(response.body)['subscribedPlaces'];
        print('allsubscriptions $allsubscriptions');
      } else {
        allsubscriptions = "Failed to get allsubscriptions";
      }
    } catch (e) {
      print("all subscription fetch error ${e.toString()})");
    }
    return allsubscriptions;
  }
}
