import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:zombies/components/world.dart';
import 'assets.dart';

class ZombieGame extends FlameGame with HasKeyboardHandlerComponents {
  ZombieGame() : world = ZombieWorld(children: []) {
    cameraComponent = CameraComponent(world: world);
    images.prefix = '';
  }

  @override
  final ZombieWorld world;
  late final CameraComponent cameraComponent;
  Vector2 get worldSize => world.worldSize;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAll([
      Assets.assets_characters_Adventurer_Poses_adventurer_action1_png,
      Assets.assets_town_tile_0000_png,
      Assets.assets_characters_Zombie_Poses_zombie_action1_png,
    ]);
    add(world);
    add(cameraComponent);
  }
}
