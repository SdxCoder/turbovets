import 'package:json_annotation/json_annotation.dart';

part 'auth_record_dto.g.dart';

@JsonSerializable()
class AuthRecordDto {
  const AuthRecordDto({this.email, this.hashedPassword});

  final String? email;
  @JsonKey(name: 'hashed_password')
  final String? hashedPassword;

  factory AuthRecordDto.fromJson(Map<String, dynamic> json) =>
      _$AuthRecordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRecordDtoToJson(this);
}
