import 'package:frontend/DataProvider/Holyplace/Holyplace.dart';
import 'package:frontend/Models/models.dart';

class HolyPlaceRepository {
  static Future<dynamic> getAllHolyplaces() async {
    return await HolyPlaceDataProvovider.getAllHolyplaces();
  }

  static Future<dynamic> createHolyPlace(HolyplaceModel holyplaceModel) async {
    return await  HolyPlaceDataProvovider.createHolyPlace(holyplaceModel);
  }

}
