import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:yokapos/core/constants/api_constant.dart';
import 'package:yokapos/core/errors/failures.dart';
import 'package:yokapos/core/models/base_response_model.dart';
import 'package:yokapos/core/network/dio_client.dart';
import 'package:yokapos/features/auth/data/models/requests/login_request_model.dart';
import 'package:yokapos/features/auth/data/models/requests/register_request_model.dart';
import 'package:yokapos/features/auth/data/models/responses/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, BaseResponseModel<LoginResponseModel>?>> login({
    required LoginRequestModel request,
  });

  Future<Either<Failure, BaseResponseModel<String>?>> logout();
  Future<Either<Failure, BaseResponseModel<String>?>> register({
    required RegisterRequestModel request,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, BaseResponseModel<LoginResponseModel>?>> login({
    required LoginRequestModel request,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.loginUrl,
        data: request.toJson(),
      );
      final result = Right<Failure, BaseResponseModel<LoginResponseModel>?>(
        BaseResponseModel<LoginResponseModel>.fromJson(
          response.data,
          (json) => LoginResponseModel.fromJson(json),
        ),
      );
      return result;
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(
          ServerFailure(
            message: e.response?.data['message'] ?? 'Unknown error',
          ),
        );
      }
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponseModel<String>?>> logout() async {
    try {
      final response = await _dio.post(ApiConstants.logoutUrl);
      return Right<Failure, BaseResponseModel<String>?>(
        BaseResponseModel.fromJson(response.data, (json) => json['message']),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(
          ServerFailure(
            message: e.response?.data['message'] ?? 'Unknown error',
          ),
        );
      }
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponseModel<String>?>> register({
    required RegisterRequestModel request,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.registerUrl,
        data: request.toJson(),
      );
      return Right<Failure, BaseResponseModel<String>?>(
        BaseResponseModel.fromJson(response.data, (json) => json['message']),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(
          ServerFailure(
            message: e.response?.data['message'] ?? 'Unknown error',
          ),
        );
      }
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
