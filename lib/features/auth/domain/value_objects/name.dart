import 'package:equatable/equatable.dart';

class Name extends Equatable {
  const Name._(this.value, this.isValid);

  final String value;
  final bool isValid;

  factory Name(String? value) {
    if (value == null || value.isEmpty) {
      return Name._('', false);
    }
    if (value.trim().isEmpty) {
      return Name._(value, false);
    }
    return Name._(value, true);
  }

  @override
  List<Object?> get props => [value, isValid];
}
