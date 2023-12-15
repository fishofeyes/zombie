import 'package:flame/components.dart';
import 'package:zombies/assets.dart';
import 'package:zombies/zombie_game.dart';

class Zombie extends SpriteComponent with KeyboardHandler, HasGameReference<ZombieGame> {
  Zombie({required super.position})
      : super(
          size: Vector2.all(64),
          anchor: Anchor.center,
          priority: 1,
        );

  @override
  void onLoad() {
    sprite = sprite = Sprite(game.images.fromCache(Assets.assets_characters_Zombie_Poses_zombie_action1_png));
  }
}
