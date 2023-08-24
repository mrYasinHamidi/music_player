import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/time_util.dart';
import 'package:music_player/pages/musics/controller/musics_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'music_list_item.dart';

part 'music_preveiw.dart';

class MusicsPage extends GetView<MusicsController> {
  const MusicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: switch (controller.loadingStatus.value) {
            MusicLoadingStatus.loading => const Center(child: CircularProgressIndicator()),
            MusicLoadingStatus.error => IconButton(
                onPressed: () => controller.getMusics(retryForPermission: true),
                icon: const Icon(Icons.refresh),
              ),
            MusicLoadingStatus.success => ListView.builder(
                itemCount: controller.musics.length,
                itemBuilder: (context, index) => MusicListItem(index: index),
              ),
          },
        ),
      ),
      bottomSheet: Obx(
        () {
          final music = controller.musics.elementAtOrNull(controller.currentIndex.value);
          if (music == null) return const SizedBox();
          return MusicPreview(music: music);
        },
      ),
    );
  }
}
