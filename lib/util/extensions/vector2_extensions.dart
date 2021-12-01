import 'package:flame/components.dart';

extension Vector2Extension on Vector2 {
  Map<String, dynamic> toMap() => {
        'x': x,
        'y': y,
      };
}

Vector2 vector2FromMap(Map<String, dynamic> map) {
  return Vector2(map['x'], map['y']);
}
