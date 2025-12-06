import '../../../../core/errors/result.dart';
import '../entities/agent.dart';

abstract class AgentRepository {
  Future<Result<void>> initializeAgents(List<Agent> agents);
  Future<Result<List<Agent>>> getAgents();
}
