import 'package:frontend/Utilities/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/Models/models.dart';

class HolyPlaceDataProvovider {
  static Future<dynamic> getAllHolyplaces() async {
    dynamic holyplaces = [];

    try {
      final httpresponse = await http.get(
        Uri.parse('$API_URL/getallholyplaces'),
      );

      if (httpresponse.statusCode == 200) {
        var finalresult = jsonDecode(httpresponse.body);
        holyplaces = finalresult['holyplaces'];
      }
    } catch (e) {
      print(e.toString());
    }

    return holyplaces;
  }

  static Future<dynamic> createHolyPlace(HolyplaceModel holyplaceModel) async {
    dynamic responsemessage;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:4000/api/createHolyPlace'),
        body: holyplaceModel.tojson(),
      );
      if (response.statusCode == 201) {
        responsemessage = {"message": jsonDecode(response.body)['message']};
      }

       else {
        responsemessage = "Failed!";
      }
    } catch (e) {
      responsemessage = "Failed";
    }
    return responsemessage;
  }
}
