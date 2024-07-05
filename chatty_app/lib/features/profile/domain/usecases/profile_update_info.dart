import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:chatty_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/src/either.dart';

class ProfileUpdateInfo implements Usecase<void, ProfileUpdateInfoParams> {
  final ProfileRepository profileRepository;
  ProfileUpdateInfo(this.profileRepository);

  @override
  Future<Either<Failure, User>> call(ProfileUpdateInfoParams params) async {
    return await profileRepository.updateUserInformation(
      userId: params.userId,
      username: params.username,
      description: params.description,
      avatarUrl: params.avatarUrl,
    );
  }
}

class ProfileUpdateInfoParams {
  final String userId;
  final String username;
  final String description;
  final String avatarUrl;

  ProfileUpdateInfoParams({
    required this.userId,
    required this.username,
    required this.description,
    required this.avatarUrl,
  });
}
