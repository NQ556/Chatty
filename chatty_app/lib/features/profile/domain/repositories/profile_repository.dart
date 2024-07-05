import 'dart:io';

import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, User>> updateUserInformation({
    required String userId,
    required String username,
    required String description,
    required String avatarUrl,
  });

  Future<Either<Failure, String>> uploadImageToStorage({
    required File image,
    required String oldUrl,
  });
}
