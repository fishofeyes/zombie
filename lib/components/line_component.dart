import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:zombies/components/colored_box.dart';
import 'package:zombies/utils/line.dart';
import 'package:zombies/zombie_game.dart';

class LineComponent extends CustomPainterComponent with HasGameReference<ZombieGame> {
  LineComponent({
    required this.line,
    this.debug = false,
    this.thickness = 2,
    this.color = Colors.black,
  }) : super(
          anchor: Anchor.center,
          position: line.start,
          priority: 3,
          size: Vector2(line.length, 1),
        );

  Line line;
  final Color color;
  late RectangleComponent child;
  bool debug;
  double thickness;

  ColoredSquare? start;
  ColoredSquare? end;
  ColoredSquare? middle;

  @override
  void onLoad() {
    size = Vector2(line.dx.abs(), line.dy.abs());
    child = _LineRectComponent(
      size: Vector2(line.length, thickness),
      angle: angle,
      paint: Paint()..color = color,
      position: positionOfAnchor(anchor),
      priority: priority,
    );
    game.world.add(child);

    if (debug) {
      start = ColoredSquare.red(line.start);
      game.world.add(start!);
      end = ColoredSquare.blue(line.end);
      game.world.add(end!);
      middle = ColoredSquare(line.center);
      game.world.add(middle!);
    }
  }

  @override
  void update(double dt) {
    position = line.start;
    child.size = Vector2(line.length, thickness);
    child.angle = line.angle;
    child.position = positionOfAnchor(anchor);
  }

  @override
  void renderDebugMode(Canvas canvas) {
    return;
  }
}

class _LineRectComponent extends RectangleComponent {
  _LineRectComponent({
    required super.size,
    required super.angle,
    required super.paint,
    required super.position,
    required super.priority,
  });

  @override
  void renderDebugMode(Canvas canvas) {
    return;
  }
}
