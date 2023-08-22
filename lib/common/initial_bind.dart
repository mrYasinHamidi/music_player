import 'package:get/get.dart';
import 'package:music_player/common/music_player.dart';

class InitialBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MusicPlayer>(() => SimpleMusicPlayer());
  }
}
