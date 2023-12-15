import 'package:flame/components.dart';
import 'package:zombies/components/components.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('line', () {
    test("return 0 for flat line", () {
      expect(Line(Vector2(1, 0), Vector2(2, 0)).slope, 0);
    });
  });
}
