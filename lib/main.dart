import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/initial_bind.dart';
import 'package:music_player/common/routes_name.dart';
import 'package:music_player/pages/musics/view/binding.dart';
import 'package:music_player/pages/musics/view/page.dart';
import 'package:music_player/pages/player/view/binding.dart';
import 'package:music_player/pages/player/view/page.dart';

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
