import 'package:injectable/injectable.dart';

import '../../../../core/errors/result.dart';
import '../repositories/auth_repository.dart';

@injectable
class Logout {
  const Logout(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call() async {
    return _repository.logout();
  }
}
