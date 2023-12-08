import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class Player extends SpriteComponent with KeyboardHandler {
  Player({super.position, super.sprite})
      : super(
          size: Vector2.all(64),
          anchor: Anchor.center,
        );
  Vector2 movement = Vector2.zero();
  double speed = 30.0;
  @override
  void update(double dt) {
    position = position + movement * speed * dt;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyW) {
        movement = Vector2(movement.x, -1);
      } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
        movement = Vector2(movement.x, 1);
      }
    } else if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyW) {
        movement = Vector2(movement.x, 0);
      } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
        movement = Vector2(movement.x, 0);
      }
    }
    return false;
  }
}
