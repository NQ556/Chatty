import 'dart:io';

import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:chatty_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/src/either.dart';

class ProfileUploadImage implements Usecase<String, ProfileUploadImageParams> {
  final ProfileRepository profileRepository;
  ProfileUploadImage(this.profileRepository);

  @override
  Future<Either<Failure, String>> call(ProfileUploadImageParams params) async {
    return await profileRepository.uploadImageToStorage(
        image: params.image, oldUrl: params.oldUrl);
  }
}

class ProfileUploadImageParams {
  final File image;
  final String oldUrl;

  ProfileUploadImageParams({
    required this.image,
    required this.oldUrl,
  });
}
