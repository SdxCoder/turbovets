import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/extensions/string_extensions.dart';
import '../../domain/entities/user.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  const UserDto({this.id, this.name, this.email});

  final String? id;
  final String? name;
  final String? email;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

extension UserDtoX on UserDto {
  User toDomain() {
    return User(
      id: id.orCrash('id'),
      name: name.orCrash('name'),
      email: email.orCrash('email'),
    );
  }
}

extension UserX on User {
  UserDto toDto() {
    return UserDto(id: id, name: name, email: email);
  }
}
