import 'package:injectable/injectable.dart';

import '../../../../core/errors/result.dart';
import '../entities/agent.dart';
import '../repositories/agent_repository.dart';

@injectable
class InitializeAgents {
  const InitializeAgents(this._repository);

  final AgentRepository _repository;

  Future<Result<void>> call() async {
    const agents = [
      Agent(
        id: '1',
        imageUrl: 'https://i.pravatar.cc/150?img=1',
        name: 'Andrew Jones',
        description: 'Expert vet consultant',
      ),
      Agent(
        id: '2',
        imageUrl: 'https://i.pravatar.cc/150?img=2',
        name: 'Bryce Mosley',
        description: 'Specialized vet care advisor',
      ),
      Agent(
        id: '3',
        imageUrl: 'https://i.pravatar.cc/150?img=3',
        name: 'Donal Lundee Jr.',
        description: 'Veterans health specialist',
      ),
      Agent(
        id: '4',
        imageUrl: 'https://i.pravatar.cc/150?img=4',
        name: 'Hanako Arasaka',
        description: 'Vet nutrition expert',
      ),
      Agent(
        id: '5',
        imageUrl: 'https://i.pravatar.cc/150?img=5',
        name: 'Johnny Silverhand',
        description: 'Emergency vet care consultant',
      ),
    ];

    return _repository.initializeAgents(agents);
  }
}
