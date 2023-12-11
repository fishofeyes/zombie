import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:zombies/constants.dart';
import 'package:zombies/zombie_game.dart';

class Player extends SpriteComponent with KeyboardHandler, HasGameReference<ZombieGame> {
  Player({super.position, super.sprite})
      : super(
          size: Vector2.all(64),
          anchor: Anchor.center,
          priority: 1, // 图层显示优先级
        ) {
    halfSize = size / 2;
  }
  late Vector2 halfSize;
  late Vector2 maxPosition;

  Vector2 movement = Vector2.zero();
  double speed = 4 * worldTileSize;

  @override
  void onLoad() {
    maxPosition = game.worldSize - halfSize;
  }

  @override
  void update(double dt) {
    position.add(movement * speed * dt);
    position.clamp(halfSize, maxPosition);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyW) {
        movement = Vector2(movement.x, -1);
      } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
        movement = Vector2(movement.x, 1);
      } else if (event.logicalKey == LogicalKeyboardKey.keyA) {
        movement = Vector2(-1, movement.y);
      } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
        movement = Vector2(1, movement.y);
      }
    } else if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyW) {
        movement.y = keysPressed.contains(LogicalKeyboardKey.keyS) ? 1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
        movement.y = keysPressed.contains(LogicalKeyboardKey.keyW) ? -1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.keyA) {
        movement.x = keysPressed.contains(LogicalKeyboardKey.keyD) ? 1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
        movement.x = keysPressed.contains(LogicalKeyboardKey.keyA) ? -1 : 0;
      }
    }
    return true;
  }
}
