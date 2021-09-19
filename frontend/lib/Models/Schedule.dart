class Schedule {
  String? createdby;
  String? title;
  String? description;
  String? allprograms;
  bool? seenbyusers;
  String? id;
  Schedule(this.createdby, this.allprograms,
      {this.title, this.description, this.seenbyusers, this.id});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(json['createdby'], json['programs'],
        title: json['title'],
        description: json['description'],
        seenbyusers: json['seenbyusers'],
        id: json['_id']);
  }

  Map<String, dynamic> tojson() {
    return {
      "createdby": createdby,
      "programs ": allprograms,
      "title ": title,
      "description ": description,
      "seenbyusers": seenbyusers,
      "id": id
    };
  }
}

class ScheduleArgument {
  final Schedule? schedule;
  final bool update;

  ScheduleArgument({this.schedule, this.update = false});
}
