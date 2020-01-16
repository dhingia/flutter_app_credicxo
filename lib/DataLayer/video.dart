class Video {
  String id;
  String key;
  String name;
  var size;
  String type;

  Video.fromJson(Map json)
      : id = json['id'],
        key = json['key'],
        name = json['name'],
        size = json['size'],
        type = json['type'];
}
