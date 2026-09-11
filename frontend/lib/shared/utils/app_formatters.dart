import 'package:intl/intl.dart';

/// Shared date/time formats used across admin, seller, and employee screens.
final _dateTimeFmt = DateFormat('dd MMM yyyy, hh:mm a');
final _dateFmt = DateFormat('dd MMM yyyy');

String formatAppDateTime(DateTime date) => _dateTimeFmt.format(date.toLocal());

String formatAppDate(DateTime date) => _dateFmt.format(date.toLocal());

/// Strips the common `Exception: ` prefix from thrown messages for UI display.
String friendlyError(Object error) {
  final s = error.toString();
  return s.startsWith('Exception: ') ? s.substring(11) : s;
}
