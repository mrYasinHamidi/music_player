import 'package:get/get.dart';
import 'package:music_player/pages/musics/controller/musics_controller.dart';

class MusicsBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MusicsController());
  }
}
