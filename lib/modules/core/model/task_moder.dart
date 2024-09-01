class TaskModel {
  String title;
  String id;
  String desc;
  int date;
  String time;
  bool isDone;
  TaskModel(
      {required this.desc,
      this.id = "",
      required this.isDone,
      required this.date,
      required this.time,
      required this.title});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        title: json["title"],
        id: json["id"],
        desc: json["desc"],
        time: json["time"],
        date: json["date"],
        isDone: json["isDone"]);
  }

//     TaskModel.fromJson(Map<String,dynamic> json)
//  :
//   title=json["title"],
//     time=json["time"],
//   desc=json["desc"],
//   id=json["id"],
//   isDone=json["isDone"]

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "id": id,
      "desc": desc,
      "time": time,
      "date": date,
      "isDone": isDone,
    };
  }
}
