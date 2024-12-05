class Point {
  int x;
  int y;

  Point.fromJson(Map<String, dynamic> json)
      : x = json['x'],
        y = json['y'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['x'] = x;
    json['y'] = y;
    return json;
  }
}
