// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_record_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRecordDto _$AuthRecordDtoFromJson(Map<String, dynamic> json) =>
    AuthRecordDto(
      email: json['email'] as String?,
      hashedPassword: json['hashed_password'] as String?,
    );

Map<String, dynamic> _$AuthRecordDtoToJson(AuthRecordDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'hashed_password': instance.hashedPassword,
    };
