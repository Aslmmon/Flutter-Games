import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kings_pigs/characters/king.dart';
import 'package:kings_pigs/characters/pig.dart';

void main() {
  runApp(const KingPigGame());
}

class KingPigGame extends StatelessWidget {
  const KingPigGame({super.key});

  static double tileSize = 32;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return BonfireWidget(
        map: WorldMapByTiled(WorldMapReader.fromAsset('map.tmj'),
            objectsBuilder: {
              'pig': (properties) =>
                  Pig(position: properties.position, size: properties.size)
            }),
        backgroundColor: const Color(0xFF3F3851),
        cameraConfig: CameraConfig(
          moveOnlyMapArea: true,
            zoom: getZoomFromMaxVisibleTile(context, tileSize, 15)),
        player: King(position: Vector2(3 * tileSize, 12 * tileSize)),
        showCollisionArea: false,
        playerControllers: [
          Joystick(
            actions: [
              JoystickAction(actionId: 1),
              JoystickAction(
                actionId: 2,
                margin: const EdgeInsets.only(
                  bottom: 50,
                  right: 120,
                ),
                color: Colors.red,
              ),
            ],
            directional: JoystickDirectional(margin: const EdgeInsets.all(25)),
          )
        ]);
  }
}
