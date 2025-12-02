import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, required this.name, required this.email});

  final String id;
  final String name;
  final String email;

  bool get isValid => id.isNotEmpty && name.isNotEmpty && email.isNotEmpty;

  User copyWith({String? id, String? name, String? email}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [id, name, email];
}
