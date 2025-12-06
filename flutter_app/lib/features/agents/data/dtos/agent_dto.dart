import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/extensions/string_extensions.dart';
import '../../domain/entities/agent.dart';

part 'agent_dto.g.dart';

@JsonSerializable()
class AgentDto {
  const AgentDto({this.id, this.imageUrl, this.name, this.description});

  final String? id;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? name;
  final String? description;

  factory AgentDto.fromJson(Map<String, dynamic> json) =>
      _$AgentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AgentDtoToJson(this);
}

extension AgentDtoX on AgentDto {
  Agent toDomain() {
    return Agent(
      id: id.orCrash('id'),
      imageUrl: imageUrl.orEmpty(),
      name: name.orCrash('name'),
      description: description.orEmpty(),
    );
  }
}

extension AgentX on Agent {
  AgentDto toDto() {
    return AgentDto(
      id: id,
      imageUrl: imageUrl,
      name: name,
      description: description,
    );
  }
}
