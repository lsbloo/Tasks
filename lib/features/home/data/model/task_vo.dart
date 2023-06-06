class TaskVO {
  String crit;
  String date;
  String description;
  String title;
  String latitude;
  String longitude;
  String? id;
  String? uniqueId;
  bool favorite;

  TaskVO(this.title, this.description, this.crit, this.date, this.favorite,
      this.id, this.latitude, this.longitude, this.uniqueId);

  Map toJson() => {
        "crit": crit,
        "date": date,
        "description": description,
        "title": title,
        "id": id,
        "favorite": favorite,
        "latitude": latitude,
        "longitude": longitude,
      };

  TaskVO.fromJson(Map<String, dynamic> json, key)
      : id = json['id'],
        crit = json['crit'],
        description = json['description'],
        title = json['title'],
        favorite = json['favorite'],
        date = json['date'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        uniqueId = key;


  static List<TaskVO> listFromJson(Map<String, dynamic> json) {
    List<TaskVO> tasks = [];
    json.forEach((key, value) {
      Map<String, dynamic> item = { "id": key, ...value };
      tasks.add(TaskVO.fromJson(item,key));
    });
    return tasks;
  }
}
