import 'package:injectable/injectable.dart';
import 'package:turbovetschat/features/auth/domain/entities/user.dart';

import '../../../../core/errors/result.dart';
import '../repositories/auth_repository.dart';

typedef GetCurrentUserResult = ({User user, bool isAuthenticated});

@injectable
class GetCurrentUser {
  const GetCurrentUser(this._repository);

  final AuthRepository _repository;

  Future<Result<GetCurrentUserResult>> call() async {
    final result = await _repository.getCurrentUser();

    return result.when(
      success: (user) =>
          Result.success((user: user, isAuthenticated: user.isValid)),
      error: (failure) => Result.failure<GetCurrentUserResult>(failure),
    );
  }
}
