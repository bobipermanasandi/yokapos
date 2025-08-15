import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:yokapos/core/errors/failures.dart';
import 'package:yokapos/core/usecases/usecase.dart';
import 'package:yokapos/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LogoutUsecase implements UseCase<String?, NoParams> {
  final AuthRepository repository;

  LogoutUsecase(this.repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) {
    return repository.logout();
  }
}
