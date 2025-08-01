class Helper {
  static String formatDateTime(DateTime dateTime) {
    final localTime = dateTime.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(
      localTime.year,
      localTime.month,
      localTime.day,
    );

    String timeString =
        '${localTime.hour.toString().padLeft(2, '0')}:${localTime.minute.toString().padLeft(2, '0')}';

    if (messageDate == today) {
      return 'Today $timeString';
    } else if (messageDate == yesterday) {
      return 'Yesterday $timeString';
    } else {
      return '${localTime.day.toString().padLeft(2, '0')}/${localTime.month.toString().padLeft(2, '0')}/${localTime.year} $timeString';
    }
  }
}
