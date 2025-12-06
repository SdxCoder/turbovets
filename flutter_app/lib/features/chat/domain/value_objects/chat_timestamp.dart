import 'package:equatable/equatable.dart';
import 'package:turbovetschat/core/utils/date_formatter.dart';

class ChatTimestamp extends Equatable {
  final String value;
  final bool isValid;

  const ChatTimestamp._({required this.value, required this.isValid});

  factory ChatTimestamp({String? value}) {
    if (value == null || value.isEmpty) {
      return ChatTimestamp._(value: '', isValid: false);
    }

    final formattedDate = DateFormatter.formatTimestamp(value);
    if (formattedDate.isEmpty) {
      return ChatTimestamp._(value: '', isValid: false);
    }

    return ChatTimestamp._(value: value, isValid: true);
  }

  @override
  List<Object?> get props => [value, isValid];
}
