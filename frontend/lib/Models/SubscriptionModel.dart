class SubscriptionModel {
  String? representativeId;
  String? appUserId;
  SubscriptionModel(this.representativeId, this.appUserId);
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(json['representativeId'], json['appUserId']);
  }

  Map<String, dynamic> toJson() {
    return {"representativeId": representativeId, "appUserId": appUserId};
  }
}
