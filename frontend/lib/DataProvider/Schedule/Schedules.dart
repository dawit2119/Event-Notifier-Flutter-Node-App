import 'dart:convert';

import 'package:frontend/Utilities/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Models/Schedule.dart';

class SchedulesDataProvovider {
  static Future<dynamic> getAllPrograms(String id) async {
    dynamic schedules;
    print('uri: http://localhost:4000/api/allschedules/$id');
    try {
      final httpresponse = await http.get(
        Uri.parse('http://localhost:4000/api/allschedules/$id'),
      );
      if (httpresponse.statusCode == 200) {
        var finalresult = jsonDecode(httpresponse.body);
        schedules = finalresult['schedules'];
        print('schedules: $schedules');
      } else {
        schedules = jsonDecode(httpresponse.body)['message'];
      }
    } catch (e) {
      schedules = e.toString();
    }

    return schedules;
  }

  static Future<dynamic> getNotSeenResources(String jsonOrNumber) async {
    dynamic message;
    try {
      print("Uri: http://localhost:4000/api/$jsonOrNumber");
      final response =
          await http.get(Uri.parse('http://localhost:4000/api/$jsonOrNumber'));
      print("On Dp of new schedules");
      if (response.statusCode == 200) {
        message = jsonDecode(response.body);
        print('success');
      } else {
        message = jsonDecode(response.body);
      }
    } catch (e) {
      message = e.toString();
      print("eror $message");
    }
    return message;
  }

  static Future<dynamic> createSchedule(Schedule schedule) async {
    dynamic responsemessage;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:4000/api/createSchedule'),
        body: {
          "title": schedule.title,
          "description": schedule.description,
          "createdby": schedule.createdby,
          "programs": schedule.allprograms
        },
      );
      if (response.statusCode == 403) {
        responsemessage = {"Errormessage": response.body};
      } else if (response.statusCode == 201) {
        print(response.body);
        responsemessage = jsonDecode(response.body);
      } else
        responsemessage = response.body;
    } catch (e) {
      print(e.toString());
    }

    return responsemessage;
  }

  static Future<dynamic> updateSchedule(Schedule schedule) async {
    dynamic message;
    print("from Dp of sch");
    print("comming data is ${schedule.tojson()}");
    try {
      final response = await http.put(
         Uri.parse('http://localhost:4000/api/updateschedule'),
          body: schedule.tojson());
      if (response.statusCode == 201) {
        print('status code ${response.statusCode}');
        message = {"update": "success"};
      } else if (response.statusCode == 404) {
        message = "schedule not found";
      }
    } catch (e) {
      message = e.toString();
    }
    return message;
  }

  static Future<dynamic> deleteSchedule(Schedule schedule) async {
    dynamic message;
    try {
      final response = await http.delete(Uri.parse('$API_URL/updateschedule'),
          body: schedule.tojson());
      if (response.statusCode == 200) {
        message = {"delete": "success"};
      } else if (response.statusCode == 404) {
        message = "schedule not found";
      }
    } catch (e) {
      message = e.toString();
    }
    return message;
  }
}
