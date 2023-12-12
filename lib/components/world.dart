import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:zombies/assets.dart';
import 'package:zombies/components/player.dart';
import 'package:zombies/components/unwalkable_component.dart';
import 'package:zombies/constants.dart';
import 'package:zombies/zombie_game.dart';

class ZombieWorld extends World with HasGameRef<ZombieGame> {
  ZombieWorld({super.children});

  late final Player player;
  late final TiledComponent map;
  Vector2 get worldSize => Vector2(map.width, map.height);
  @override
  FutureOr<void> onLoad() async {
    map = await TiledComponent.load('world.tmx', Vector2.all(worldTileSize));

    final playerImage = game.images.fromCache(Assets.assets_characters_Adventurer_Poses_adventurer_action1_png);
    player = Player(position: Vector2(worldTileSize * 12.5, worldTileSize * 5.5), sprite: Sprite(playerImage));
    game.cameraComponent.follow(player);

    final objectLayer = map.tileMap.getLayer<ObjectGroup>('Objects');
    for (final o in (objectLayer?.objects ?? <TiledObject>[])) {
      if (!o.isPolygon) return;
      if (!o.properties.byName.containsKey('blocksMovement')) return;
      final veritices = <Vector2>[];
      for (final p in o.polygon) {
        veritices.add(Vector2((p.x + o.x) * worldScale, (p.y + o.y) * worldScale));
      }

      add(UnwalkableComponent(veritices));
    }
    addAll([map, player]);
  }

  @override
  void onGameResize(Vector2 size) {
    // 重置世界地图大小
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
