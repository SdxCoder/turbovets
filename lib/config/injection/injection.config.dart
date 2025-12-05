// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../core/services/hive/hive_service.dart' as _i498;
import '../../core/services/hive/index.dart' as _i402;
import '../../features/agents/data/repositories/agent_repository_impl.dart'
    as _i1045;
import '../../features/agents/domain/repositories/agent_repository.dart'
    as _i575;
import '../../features/agents/domain/usecases/get_agents.dart' as _i744;
import '../../features/agents/domain/usecases/initialize_agents.dart' as _i1025;
import '../../features/agents/presentation/bloc/agent_cubit.dart' as _i396;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_current_user.dart' as _i111;
import '../../features/auth/domain/usecases/login.dart' as _i428;
import '../../features/auth/domain/usecases/logout.dart' as _i597;
import '../../features/auth/domain/usecases/register.dart' as _i480;
import '../../features/auth/presentation/bloc/login_cubit.dart' as _i281;
import '../../features/auth/presentation/bloc/register_cubit.dart' as _i98;
import '../../features/chat/data/repositories/chat_repository_impl.dart'
    as _i504;
import '../../features/chat/domain/repositories/chat_repository.dart' as _i420;
import '../../features/chat/domain/usecases/create_chat.dart' as _i985;
import '../../features/chat/domain/usecases/watch_chats.dart' as _i381;
import '../../features/chat/presentation/bloc/chats_cubit.dart' as _i949;
import '../../features/messages/data/repositories/message_repository_impl.dart'
    as _i514;
import '../../features/messages/domain/repositories/message_repository.dart'
    as _i28;
import '../../features/messages/domain/usecases/get_messages.dart' as _i15;
import '../../features/messages/domain/usecases/mark_messages_as_read.dart'
    as _i20;
import '../../features/messages/domain/usecases/send_message.dart' as _i162;
import '../../features/messages/domain/usecases/watch_messages.dart' as _i787;
import '../../features/messages/presentation/bloc/messages_cubit.dart' as _i967;
import '../../features/splash/presentation/bloc/splash_cubit.dart' as _i955;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i498.HiveService>(() => registerModule.hiveService);
    gh.lazySingleton<_i28.MessageRepository>(
      () => _i514.MessageRepositoryImpl(gh<_i498.HiveService>()),
    );
    gh.factory<_i20.MarkMessagesAsRead>(
      () => _i20.MarkMessagesAsRead(gh<_i28.MessageRepository>()),
    );
    gh.factory<_i162.SendMessage>(
      () => _i162.SendMessage(gh<_i28.MessageRepository>()),
    );
    gh.factory<_i787.WatchMessages>(
      () => _i787.WatchMessages(gh<_i28.MessageRepository>()),
    );
    gh.lazySingleton<_i420.ChatRepository>(
      () => _i504.ChatRepositoryImpl(gh<_i498.HiveService>()),
    );
    gh.lazySingleton<_i575.AgentRepository>(
      () => _i1045.AgentRepositoryImpl(gh<_i498.HiveService>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i402.HiveService>()),
    );
    gh.factory<_i744.GetAgents>(
      () => _i744.GetAgents(gh<_i575.AgentRepository>()),
    );
    gh.factory<_i1025.InitializeAgents>(
      () => _i1025.InitializeAgents(gh<_i575.AgentRepository>()),
    );
    gh.factory<_i381.WatchChats>(
      () => _i381.WatchChats(gh<_i420.ChatRepository>()),
    );
    gh.factory<_i15.GetChatById>(
      () => _i15.GetChatById(gh<_i420.ChatRepository>()),
    );
    gh.factory<_i985.CreateChat>(
      () => _i985.CreateChat(
        gh<_i420.ChatRepository>(),
        gh<_i787.AuthRepository>(),
      ),
    );
    gh.factory<_i111.GetCurrentUser>(
      () => _i111.GetCurrentUser(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i428.Login>(() => _i428.Login(gh<_i787.AuthRepository>()));
    gh.factory<_i597.Logout>(() => _i597.Logout(gh<_i787.AuthRepository>()));
    gh.factory<_i480.Register>(
      () => _i480.Register(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i949.ChatsCubit>(
      () => _i949.ChatsCubit(gh<_i985.CreateChat>(), gh<_i381.WatchChats>()),
    );
    gh.factory<_i967.MessagesCubit>(
      () => _i967.MessagesCubit(
        gh<_i15.GetChatById>(),
        gh<_i162.SendMessage>(),
        gh<_i787.WatchMessages>(),
        gh<_i20.MarkMessagesAsRead>(),
      ),
    );
    gh.factory<_i396.AgentCubit>(
      () => _i396.AgentCubit(
        gh<_i1025.InitializeAgents>(),
        gh<_i744.GetAgents>(),
      ),
    );
    gh.factory<_i281.LoginCubit>(() => _i281.LoginCubit(gh<_i428.Login>()));
    gh.factory<_i955.SplashCubit>(
      () => _i955.SplashCubit(gh<_i111.GetCurrentUser>()),
    );
    gh.factory<_i98.RegisterCubit>(
      () => _i98.RegisterCubit(gh<_i480.Register>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
