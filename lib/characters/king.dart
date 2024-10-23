import 'package:bonfire/bonfire.dart';
import 'package:flutter/cupertino.dart';

class King extends PlatformPlayer with HandleForces {
  King({required super.position}) : super(size: Vector2(78, 58));

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);
    super.render(canvas);
  }

  @override
  void onJoystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN && event.id == 1) {
      jump( jumpSpeed: 200);
    }
    super.onJoystickAction(event);
  }

  @override
  Future<void> onLoad() {
    addForce(GravityForce2D(value: Vector2(0, 1000)));
    add(RectangleHitbox(size: size));
    return super.onLoad();
  }
}
