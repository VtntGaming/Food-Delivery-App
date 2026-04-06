String formatVnd(num value) {
  final raw = value.round().toString();
  final reversed = raw.split('').reversed.toList();
  final buffer = StringBuffer();

  for (var i = 0; i < reversed.length; i++) {
    buffer.write(reversed[i]);
    final isGroupEnd = (i + 1) % 3 == 0;
    final hasMore = i + 1 < reversed.length;
    if (isGroupEnd && hasMore) {
      buffer.write('.');
    }
  }

  final formatted = buffer.toString().split('').reversed.join();
  return '$formattedđ';
}
