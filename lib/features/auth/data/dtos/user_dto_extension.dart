import '../../../../core/utils/extensions/string_extensions.dart';
import '../../domain/entities/user.dart';
import 'user_dto.dart';

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
