import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:zombies/assets.dart';
import 'package:zombies/components/line_component.dart';
import 'package:zombies/constants.dart';
import 'package:zombies/utils/line.dart';
import 'package:zombies/utils/movement.dart';
import 'package:zombies/zombie_game.dart';

class Zombie extends SpriteComponent with KeyboardHandler, HasGameReference<ZombieGame>, MovementReference {
  Zombie({required super.position, this.speed = worldTileSize * 1})
      : super(
          size: Vector2.all(64),
          anchor: Anchor.center,
          priority: 1,
        );
  LineComponent? line;
  double speed;

  @override
  void onLoad() {
    sprite = Sprite(game.images.fromCache(Assets.assets_characters_Zombie_Poses_zombie_action1_png));
  }

  @override
  void update(double dt) {
    final pathToPlayer = Line(position, game.world.player.position);
    if (line == null) {
      line = LineComponent(line: pathToPlayer, color: Colors.blue);
      game.world.add(line!);
    } else {
      line!.line = pathToPlayer;
    }

    moveAlongPath(pathToPlayer, dt);
  }

  void moveAlongPath(Line pathToPlayer, double dt) {
    final originalPosition = position.clone();

    final movement = pathToPlayer.vector2.normalized();
    final movementFrame = movement * speed * dt;

    position.add(movementFrame);
    applyMovement(originalPosition, movementFrame);
    position = originalPosition + movementFrame;
  }
}
