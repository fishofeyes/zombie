import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:zombies/components/unwalkable_component.dart';
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
    final originalPosition = position.clone();
    final movementFrame = movement * speed * dt;
    position.add(movementFrame);
    if (movementFrame.y < 0) {
      // moving up
      final newTop = positionOfAnchor(Anchor.topCenter);
      final _list = game.world.componentsAtPoint(newTop);
      print("newTop: $newTop, list:$_list");
      for (final e in _list) {
        if (e is UnwalkableComponent) {
          movementFrame.y = 0;
          break;
        }
      }
    }
    if (movementFrame.y > 0) {
      // moving down
      final newBottom = positionOfAnchor(Anchor.bottomCenter);
      for (final e in game.world.componentsAtPoint(newBottom)) {
        if (e is UnwalkableComponent) {
          movementFrame.y = 0;
          break;
        }
      }
    }
    if (movementFrame.x < 0) {
      final newLeft = positionOfAnchor(Anchor.centerLeft);
      for (final e in game.world.componentsAtPoint(newLeft)) {
        if (e is UnwalkableComponent) {
          movementFrame.x = 0;
          break;
        }
      }
    }
    if (movementFrame.x > 0) {
      final newRight = positionOfAnchor(Anchor.centerRight);
      for (final e in game.world.componentsAtPoint(newRight)) {
        if (e is UnwalkableComponent) {
          movementFrame.x = 0;
          break;
        }
      }
    }
    position = originalPosition + movementFrame;
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
