import 'package:equatable/equatable.dart';

class Password extends Equatable {
  const Password._(this.value, this.isValid);

  final String value;
  final bool isValid;

  factory Password(String? value) {
    if (value == null || value.isEmpty) {
      return Password._('', false);
    }
    if (value.length < 6) {
      return Password._(value, false);
    }
    return Password._(value, true);
  }

  @override
  List<Object?> get props => [value, isValid];
}
