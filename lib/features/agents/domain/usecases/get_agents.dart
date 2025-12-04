import 'package:injectable/injectable.dart';

import '../../../../core/errors/result.dart';
import '../entities/agent.dart';
import '../repositories/agent_repository.dart';

@injectable
class GetAgents {
  const GetAgents(this._repository);

  final AgentRepository _repository;

  Future<Result<List<Agent>>> call() async {
    return _repository.getAgents();
  }
}
