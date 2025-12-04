import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/agent.dart';

class AgentState extends Equatable {
  const AgentState({
    this.agents = const [],
    this.isLoading = false,
    this.failure,
  });

  final List<Agent> agents;
  final bool isLoading;
  final Failure? failure;

  factory AgentState.initial() {
    return const AgentState();
  }

  AgentState copyWith({
    List<Agent>? agents,
    bool? isLoading,
    Failure? failure,
  }) {
    return AgentState(
      agents: agents ?? this.agents,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [agents, isLoading, failure];
}
