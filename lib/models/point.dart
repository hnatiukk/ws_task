class Point {
  int x;
  int y;

  Point(this.x, this.y);

  Point.fromJson(Map<String, dynamic> json)
      : x = json['x'],
        y = json['y'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['x'] = x;
    json['y'] = y;
    return json;
  }

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
