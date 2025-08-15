import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:yokapos/core/errors/failures.dart';
import 'package:yokapos/core/usecases/usecase.dart';
import 'package:yokapos/features/auth/data/models/requests/register_request_model.dart';
import 'package:yokapos/features/auth/domain/repositories/auth_repository.dart';

@injectable
class RegisterUsecase implements UseCase<String?, RegisterParam> {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, String?>> call(RegisterParam params) async {
    return await repository.register(request: params.request);
  }
}

class RegisterParam extends Equatable {
  final RegisterRequestModel request;

  const RegisterParam({required this.request});

  @override
  List<Object> get props => [request];
}
