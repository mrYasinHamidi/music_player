import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/routes_name.dart';
import 'package:music_player/pages/musics/view/binding.dart';
import 'package:music_player/pages/musics/view/page.dart';

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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.musics,
      getPages: _pages(),
    );
  }
}
