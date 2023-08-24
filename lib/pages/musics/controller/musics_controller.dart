import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicsController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();

  final musics = <SongModel>[].obs;
  final loadingStatus = MusicLoadingStatus.loading.obs;
  final currentIndex = 0.obs;
  final playing = false.obs;
  final position = Duration.zero.obs;

  final _player = AudioPlayer();

  @override
  void onInit() {
    getMusics();
    once(musics, _setupPlayer);
    super.onInit();
  }

  void getMusics({bool retryForPermission = false}) async {
    try {
      loadingStatus.value = MusicLoadingStatus.loading;

      final hasPermission = await audioQuery.checkAndRequest(retryRequest: retryForPermission);
      if (hasPermission) {
        musics.value = await audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        );
        loadingStatus.value = MusicLoadingStatus.success;
      } else {
        loadingStatus.value = MusicLoadingStatus.error;
      }
    } catch (e) {
      loadingStatus.value = MusicLoadingStatus.error;
    }
  }

  void _setupPlayer(List<SongModel> musics) async {
    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: musics.map((e) => AudioSource.file(e.data)).toList(),
    );

    await _player.setAudioSource(playlist, initialIndex: 0, initialPosition: Duration.zero);

    _player.currentIndexStream.listen((event) {
      currentIndex.value = event ?? currentIndex.value;
    });
    _player.playingStream.listen((event) {
      playing.value = event;
    });
    _player.positionStream.listen((event) {
      position.value = event;
    });
  }

  void playPause(int index) async {
    if (currentIndex.value == index) {
      if (playing.value) {
        await _player.pause();
      } else {
        await _player.play();
      }
    } else {
      await _player.seek(Duration.zero, index: index);
      await _player.play();
    }
  }

  void next() {
    _player.seekToNext();
  }

  void previous() {
    _player.seekToPrevious();
  }

  void seekTo(Duration position){
    _player.seek(position);
  }

  @override
  void onClose() async {
    await _player.dispose();
    super.onClose();
  }
}

enum MusicLoadingStatus {
  error,
  loading,
  success,
}
