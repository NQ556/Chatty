import 'dart:io';
import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/features/profile/data/datasources/profile_datasource.dart';
import 'package:chatty_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDataSource;
  ProfileRepositoryImpl(this.profileDataSource);

  @override
  Future<Either<Failure, User>> updateUserInformation({
    required String userId,
    required String username,
    required String description,
    required String avatarUrl,
  }) async {
    try {
      final user = await profileDataSource.updateUserInformation(
        userId: userId,
        username: username,
        description: description,
        avatarUrl: avatarUrl,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImageToStorage({
    required File image,
    required String oldUrl,
  }) async {
    try {
      final result = await profileDataSource.uploadImageToStorage(
        image: image,
        oldUrl: oldUrl,
      );

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
