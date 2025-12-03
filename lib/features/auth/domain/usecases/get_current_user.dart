import 'package:injectable/injectable.dart';

import '../../../../core/errors/result.dart';
import '../repositories/auth_repository.dart';

@injectable
class GetCurrentUser {
  const GetCurrentUser(this._repository);

  final AuthRepository _repository;

  Future<bool> call() async {
    final result = await _repository.getCurrentUser();

    return result.when<bool>(
      success: (user) => user.isValid,
      error: (failure) => false,
    );
  }
}
