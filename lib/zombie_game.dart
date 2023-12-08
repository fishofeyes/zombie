import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:zombies/components/world.dart';

import 'assets.dart';

class ZombieGame extends FlameGame with HasKeyboardHandlerComponents {
  ZombieGame() : _world = ZombieWorld(children: []) {
    cameraComponent = CameraComponent(world: _world);
    images.prefix = '';
  }

  final ZombieWorld _world;
  late final CameraComponent cameraComponent;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAll([
      Assets.assets_characters_Adventurer_Poses_adventurer_action1_png,
      Assets.assets_town_tile_0000_png,
    ]);
    cameraComponent.viewfinder.anchor = Anchor.center;
    add(_world);
    add(cameraComponent);
    cameraComponent.follow(_world.player);
    return super.onLoad();
  }
}
