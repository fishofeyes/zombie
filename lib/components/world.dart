import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:zombies/assets.dart';
import 'package:zombies/components/land.dart';
import 'package:zombies/components/player.dart';
import 'package:zombies/constants.dart';
import 'package:zombies/zombie_game.dart';

class ZombieWorld extends World with HasGameRef<ZombieGame> {
  ZombieWorld({super.children});

  final List<Land> land = [];
  late final Player player;
  late final TiledComponent worldComponent;
  Vector2 get worldSize => Vector2(worldComponent.width, worldComponent.height);
  @override
  FutureOr<void> onLoad() async {
    worldComponent = await TiledComponent.load('world.tmx', Vector2.all(worldTileSize));
    add(worldComponent);

    final playerImage = game.images.fromCache(Assets.assets_characters_Adventurer_Poses_adventurer_action1_png);
    player = Player(position: Vector2(worldTileSize * 12.5, worldTileSize * 5.5), sprite: Sprite(playerImage));
    add(player);

    _resizeCamera();
    game.cameraComponent.follow(player);
  }

  @override
  void onGameResize(Vector2 size) {
    if (!gameRef.cameraComponent.isMounted) return;
    _resizeCamera();
    super.onGameResize(size);
  }

  void _resizeCamera() {
    // 设置相机
    final rect = Rectangle.fromLTRB(
      gameRef.size.x / 2,
      gameRef.size.y / 2,
      worldSize.x - gameRef.size.x / 2,
      worldSize.y - gameRef.size.y / 2,
    );
    gameRef.cameraComponent.setBounds(rect);
  }
}
