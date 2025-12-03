import 'package:equatable/equatable.dart';

class Email extends Equatable {
  const Email._(this.value, this.isValid);

  final String value;
  final bool isValid;

  factory Email(String? value) {
    if (value == null || value.isEmpty) {
      return Email._('', false);
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    final isValid = emailRegex.hasMatch(value);
    return Email._(value, isValid);
  }

  @override
  List<Object?> get props => [value, isValid];
}
