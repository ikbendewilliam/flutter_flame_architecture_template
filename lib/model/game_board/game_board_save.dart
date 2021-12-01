import 'dart:convert';

import 'package:flame/components.dart';
import 'package:flutter_flame_architecture_template/util/extensions/vector2_extensions.dart';

class GameBoardSave {
  final String? campaignId;
  final Vector2 boardSize;

  GameBoardSave({
    required this.boardSize,
    this.campaignId,
  });

  Map<String, dynamic> toMap() {
    return {
      'campaignId': campaignId,
      'boardSize': boardSize.toMap(),
    };
  }

  factory GameBoardSave.fromMap(Map<String, dynamic> map) {
    return GameBoardSave(
      campaignId: map['campaignId'],
      boardSize: vector2FromMap(map['size']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GameBoardSave.fromJson(String source) => GameBoardSave.fromMap(json.decode(source));
}
