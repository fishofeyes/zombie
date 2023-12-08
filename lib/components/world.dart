import 'dart:async';

import 'package:flame/components.dart';
import 'package:zombies/assets.dart';
import 'package:zombies/components/land.dart';
import 'package:zombies/components/player.dart';
import 'package:zombies/zombie_game.dart';

class ZombieWorld extends World with HasGameRef<ZombieGame> {
  ZombieWorld({super.children});

  final List<Land> land = [];
  late final Player player;

  static Vector2 size = Vector2.all(100);

  @override
  FutureOr<void> onLoad() async {
    final image = game.images.fromCache(Assets.assets_town_tile_0000_png);
    final playerImage = game.images.fromCache(Assets.assets_characters_Adventurer_Poses_adventurer_action1_png);
    land.add(Land(position: Vector2.all(0), sprite: Sprite(image)));
    addAll(land);

    player = Player(position: Vector2.all(20), sprite: Sprite(playerImage));
    add(player);

    return super.onLoad();
  }
}
