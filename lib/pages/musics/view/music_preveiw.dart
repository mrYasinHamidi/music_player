part of 'page.dart';

class MusicPreview extends GetView<MusicsController> {
  final SongModel music;

  const MusicPreview({super.key, required this.music});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          music.displayName ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          music.artist ?? '',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  QueryArtworkWidget(
                    id: music.id,
                    type: ArtworkType.AUDIO,
                    controller: controller.audioQuery,
                    artworkBorder: BorderRadius.circular(8),
                    artworkWidth: 40,
                    artworkHeight: 40,
                    nullArtworkWidget: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.music_note),
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => Slider(
              value: controller.position.value.inMilliseconds.toDouble(),
              max: music.duration?.toDouble() ?? 0,
              onChanged: (value) => controller.seekTo(Duration(milliseconds: value.toInt())),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    TimeUtil.formatTime(controller.position.value),
                  ),
                ),
                Text(
                  TimeUtil.formatTime(
                    Duration(milliseconds: music.duration ?? 0),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: controller.previous,
                iconSize: 48,
                icon: const Icon(Icons.skip_previous),
              ),
              IconButton(
                onPressed: () => controller.playPause(controller.currentIndex.value),
                iconSize: 48,
                icon: Obx(
                  () => controller.playing.value ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                ),
              ),
              IconButton(
                onPressed: controller.next,
                iconSize: 48,
                icon: const Icon(
                  Icons.skip_next,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
