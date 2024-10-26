import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:kings_pigs/main.dart';
import 'package:kings_pigs/utils/animation/pigsprites.dart';

class Pig extends PlatformEnemy with UseLifeBar {
  Pig({required super.position, required super.size})
      : super(
          speed: 40,
          animation: pigSprites.animations,
        ) {
    setupLifeBar(
      borderRadius: BorderRadius.circular(50),
      barLifeDrawPosition: BarLifeDrawPosition.bottom,
      offset: Vector2(0, 2),
    );
  }

  @override
  Future<void> onLoad() {
    add(RectangleHitbox(size: Vector2.all(15), position: Vector2(7, 13)));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    seeAndMoveToPlayer(
        radiusVision: KingPigGame.tileSize * 2,
        movementAxis: MovementAxis.horizontal,
      closePlayer: _closePlayer,
      notObserved: () {
        // runRandomMovement()
        return false;
      },
    );
    super.update(dt);
  }

  @override
  void onReceiveDamage(AttackOriginEnum attacker, double damage, identify) {
    animation?.playOnceOther('hit', runToTheEnd: true, useCompFlip: true);

    super.onReceiveDamage(attacker, damage, identify);
  }


  Future<void> _closePlayer(Player player) async {
    if (checkInterval('execAttack', 1000, dtUpdate)) {
      animation?.playOnceOther(
        'attack',
        runToTheEnd: true,
        useCompFlip: true,
      );

      await Future.delayed(const Duration(milliseconds: 100));

      simpleAttackMeleeByDirection(
        direction: directionThatPlayerIs(),
        damage: 10,
        size: size /2,
        attackFrom: AttackOriginEnum.ENEMY,
        withPush: false,
      );
    }
  }
  @override
  void onDie() {
    super.onDie();
    stopMove();
    animation?.playOnceOther('dead',
        runToTheEnd: true, useCompFlip: true, onFinish: removeFromParent);
  }
}
