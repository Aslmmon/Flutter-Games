import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:kings_pigs/characters/king.dart';

void main() {
  runApp(const MyApp());
}

const double tileSize = 32;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
        map: WorldMapByTiled(WorldMapReader.fromAsset('map.tmj')),
        backgroundColor: const Color(0xFF3F3851),
        cameraConfig: CameraConfig(
            zoom: getZoomFromMaxVisibleTile(context, tileSize, 15)),
        player: King(position: Vector2(3 * tileSize, 12 * tileSize)),
        showCollisionArea: true,
        playerControllers: [
          Joystick(
            actions: [JoystickAction(actionId: 1)],
            directional: JoystickDirectional(),
          )
        ]);
  }
}
