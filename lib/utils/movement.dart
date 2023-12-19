import 'package:flame/components.dart';
import 'package:zombies/zombie_game.dart';

import '../components/unwalkable_component.dart';

mixin MovementReference on SpriteComponent, HasGameReference<ZombieGame> {
  void applyMovement(Vector2 originalPosition, Vector2 movementFrame) {
    if (movementFrame.y < 0) {
      // moving up
      final newTop = positionOfAnchor(Anchor.topCenter);
      final _list = game.world.componentsAtPoint(newTop);
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
  }
}
