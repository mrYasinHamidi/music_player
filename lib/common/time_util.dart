class TimeUtil {

  ///Duration in a manner form of string
  ///ex:
  ///02:04:32
  ///43:20
  ///
  ///Supports Hour , Minute and Second
  static String formatTime(Duration duration) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final seconds = strDigits(duration.inSeconds.remainder(60));
    final minutes = strDigits(duration.inMinutes.remainder(60));
    final hour = strDigits(duration.inHours.remainder(60));

    if (hour == '00') {
      return '$minutes:$seconds';
    }

    return '$hour:$minutes:$seconds';
  }
}
