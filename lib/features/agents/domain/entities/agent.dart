import 'package:equatable/equatable.dart';

class Agent extends Equatable {
  const Agent({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  final String id;
  final String imageUrl;
  final String name;
  final String description;

  bool get isValid => id.isNotEmpty && name.isNotEmpty;

  @override
  List<Object?> get props => [id, imageUrl, name, description];
}
