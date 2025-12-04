import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/result.dart';
import '../../domain/usecases/get_agents.dart';
import '../../domain/usecases/initialize_agents.dart';
import 'agent_state.dart';

@injectable
class AgentCubit extends Cubit<AgentState> {
  AgentCubit(this._initializeAgents, this._getAgents)
    : super(AgentState.initial());

  final InitializeAgents _initializeAgents;
  final GetAgents _getAgents;

  Future<void> initializeAgents() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _initializeAgents();

    switch (result) {
      case Success():
        await loadAgents();
      case Error(:final failure):
        emit(state.copyWith(isLoading: false, failure: failure));
    }
  }

  Future<void> loadAgents() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _getAgents();

    switch (result) {
      case Success(:final data):
        emit(state.copyWith(agents: data, isLoading: false, failure: null));
      case Error(:final failure):
        emit(state.copyWith(isLoading: false, failure: failure));
    }
  }
}
