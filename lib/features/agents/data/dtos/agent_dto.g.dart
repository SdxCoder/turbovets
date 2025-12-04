// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgentDto _$AgentDtoFromJson(Map<String, dynamic> json) => AgentDto(
  id: json['id'] as String?,
  imageUrl: json['image_url'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$AgentDtoToJson(AgentDto instance) => <String, dynamic>{
  'id': instance.id,
  'image_url': instance.imageUrl,
  'name': instance.name,
  'description': instance.description,
};
