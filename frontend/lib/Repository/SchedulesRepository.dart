import 'package:frontend/DataProvider/Schedule/Schedules.dart';
import 'package:frontend/Models/Schedule.dart';

class SchedulesRepository {
  static Future<dynamic> allScheduleRepo(String id) async {
    print("passed Schedule  repo");
    return await SchedulesDataProvovider.getAllPrograms(id);
  }

  static Future<dynamic> createSchedule(Schedule schedule) async {
    print("passed Schedule  repo");
    return await SchedulesDataProvovider.createSchedule(schedule);
  }

  static Future<dynamic> getNotSeenResources(String jsonOrNumber) async {
    return await SchedulesDataProvovider.getNotSeenResources(jsonOrNumber);
  }

  static Future<dynamic> updateSchedule(Schedule schedule) async {
    return await SchedulesDataProvovider.updateSchedule(schedule);
  }

  static Future<dynamic> deleteSchedule(Schedule schedule) async {
    return await SchedulesDataProvovider.deleteSchedule(schedule);
  }
}
