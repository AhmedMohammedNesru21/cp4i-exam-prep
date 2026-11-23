import 'dart:math';

/// Option letter for a display position (0 -> A).
String optionLetter(int displayIndex) => String.fromCharCode(65 + displayIndex);

/// Random option order per question: displayed position -> original option index.
/// Shuffling prevents memorizing answer positions (A/B/C/D) across attempts.
Map<String, List<int>> buildOptionOrder(Map<String, int> optionCounts, {Random? random}) {
  final rnd = random ?? Random();
  return {
    for (final e in optionCounts.entries) e.key: List<int>.generate(e.value, (i) => i)..shuffle(rnd),
  };
}

String formatDuration(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return h > 0 ? '$h:$m:$s' : '$m:$s';
}

String formatPercent(double value, {int decimals = 1}) => '${value.toStringAsFixed(decimals)}%';

String formatDate(DateTime d) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  final hh = d.hour.toString().padLeft(2, '0');
  final mm = d.minute.toString().padLeft(2, '0');
  return '${d.day} ${months[d.month - 1]} ${d.year}, $hh:$mm';
}
