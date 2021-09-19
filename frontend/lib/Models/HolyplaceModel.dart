class HolyplaceModel {
  String? createdby;
  String? name;
  String? location;
  String? history;
  String? image;

  HolyplaceModel(this.createdby, this.name,
      {this.location, this.history, this.image});

  factory HolyplaceModel.fromJson(Map<String, dynamic> json) {
    return HolyplaceModel(
      json['creator_by'],
      json['name'],
      location:json['location'],
      history:json['history'],
      image:json['image'],
      
    );
  }

  Map<String, dynamic> tojson() {
    return {"createdby": createdby, "name": name,"location": location,"history": history,"image": image};
  }
}
