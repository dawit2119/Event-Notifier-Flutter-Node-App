import 'package:frontend/DataProvider/Subscription/subscripton.dart';
import 'package:frontend/Models/SubscriptionModel.dart';

class SubscriptionRepository {
  static Future<dynamic> subscribe(SubscriptionModel subscriptionModel) {
    return SubscriptionDataProvider.subscribe(subscriptionModel);
  }

  static Future<dynamic> unSubscribe(SubscriptionModel subscriptionModel) {
    return SubscriptionDataProvider.unSubscribe(subscriptionModel);
  }

  static Future<List<dynamic>> getAllSubscriptions(String id) {
    return SubscriptionDataProvider.getAllSubscriptions(id);
  }
}
