class DateFormatter {
  static String formatTimestamp(String isoDateString) {
    try {
      final dateTime = DateTime.parse(isoDateString);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (date == today) {
        return _formatTime(dateTime);
      } else if (date == yesterday) {
        return 'Yesterday';
      } else if (now.difference(dateTime).inDays < 7) {
        return _getDayName(dateTime.weekday);
      } else {
        return _formatDate(dateTime);
      }
    } catch (e) {
      return '';
    }
  }

  static String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return '$displayHour:$minute $period';
  }

  static String _getDayName(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday - 1];
  }

  static String _formatDate(DateTime dateTime) {
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final year = dateTime.year.toString().substring(2);

    return '$month/$day/$year';
  }
}
