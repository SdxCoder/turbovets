import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/hive/exceptions.dart';
import '../../../../core/services/hive/hive_content.dart';
import '../../../../core/services/hive/hive_service.dart';
import '../../domain/entities/agent.dart';
import '../../domain/repositories/agent_repository.dart';
import '../dtos/agent_dto.dart';

@LazySingleton(as: AgentRepository)
class AgentRepositoryImpl implements AgentRepository {
  final HiveService _hiveService;
  AgentRepositoryImpl(this._hiveService);

  static const String _agentsRecordKey = 'agents_record';

  @override
  Future<Result<void>> initializeAgents(List<Agent> agents) async {
    try {
      final agentsDto = agents.map((agent) => agent.toDto()).toList();
      final agentsJson = agentsDto.map((dto) => dto.toJson()).toList();

      await _hiveService.save(
        HiveContent.listMap(key: _agentsRecordKey, value: agentsJson),
      );

      return Result.success(null);
    } on CacheWriteException {
      return Result.failure(CacheWriteFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  Future<Result<List<Agent>>> getAgents() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final agentsJson = _hiveService.readListMap<AgentDto>(
        _agentsRecordKey,
        fromJson: AgentDto.fromJson,
      );

      if (agentsJson == null) {
        return Result.success([]);
      }

      final agents = agentsJson.map((dto) => dto.toDomain()).toList();

      return Result.success(agents);
    } on CacheReadException {
      return Result.failure(CacheReadFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }
}
