import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:zombies/components/line_component.dart';
import 'package:zombies/components/player.dart';
import 'package:zombies/components/unwalkable_component.dart';
import 'package:zombies/components/zombie.dart';
import 'package:zombies/constants.dart';
import 'package:zombies/utils/line.dart';
import 'package:zombies/zombie_game.dart';

class ZombieWorld extends World with HasGameRef<ZombieGame> {
  ZombieWorld({super.children});

  late final Player player;
  late final TiledComponent map;
  Vector2 get worldSize => Vector2(map.width, map.height);

  final unwalkableComponentEdge = <Line>[];

  @override
  FutureOr<void> onLoad() async {
    map = await TiledComponent.load('world.tmx', Vector2.all(worldTileSize));

    final objectLayer = map.tileMap.getLayer<ObjectGroup>('Objects');
    for (final o in (objectLayer?.objects ?? <TiledObject>[])) {
      if (!o.isPolygon) return;
      if (!o.properties.byName.containsKey('blocksMovement')) return;
      final veritices = <Vector2>[];
      Vector2? lastPoint;
      Vector2? firstPoint;

      for (final p in o.polygon) {
        final nextPoint = Vector2((p.x + o.x) * worldScale, (p.y + o.y) * worldScale);
        firstPoint ??= nextPoint;
        veritices.add(nextPoint);
        if (lastPoint != null) {
          unwalkableComponentEdge.add(Line(lastPoint, nextPoint));
        }
        lastPoint = nextPoint;
      }
      unwalkableComponentEdge.add(Line(lastPoint!, firstPoint!));
      add(UnwalkableComponent(veritices));
    }

    for (final line in unwalkableComponentEdge) {
      add(LineComponent(line: line, color: Colors.red));
    }

    final zombie = Zombie(
      position: Vector2(worldTileSize * 15.5, worldTileSize * 5),
    );
    player = Player();
    game.cameraComponent.follow(player);
    addAll([map, player, zombie]);
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
