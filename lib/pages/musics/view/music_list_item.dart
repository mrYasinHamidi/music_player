part of 'page.dart';

class MusicListItem extends GetView<MusicsController> {
  final int index;

  const MusicListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final music = controller.musics.elementAt(index);
    return ListTile(
      leading: IconButton(
        onPressed: () => index == controller.currentIndex.value && controller.playing.value
            ? controller.pause()
            : controller.play(index),
        icon: index == controller.currentIndex.value && controller.playing.value
            ? const Icon(Icons.pause)
            : const Icon(Icons.play_arrow),
      ),
      title: Text(music.displayName),
      subtitle: Text(music.artist ?? music.album ?? music.displayName),
    );
  }
}
