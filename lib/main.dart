import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/views/initial_bind.dart';
import 'package:music_player/views/musics/binding.dart';
import 'package:music_player/views/musics/page.dart';
import 'package:music_player/views/player/binding.dart';
import 'package:music_player/views/player/page.dart';
import 'package:music_player/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List<GetPage> _pages() {
    return [
      GetPage(
        name: RoutesName.musics,
        page: () => const MusicsPage(),
        binding: MusicsBind(),
      ),
      GetPage(
        name: RoutesName.player,
        page: () => const PlayerPage(),
        binding: PlayerBind(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBind(),
      getPages: _pages(),
    );
  }
}
