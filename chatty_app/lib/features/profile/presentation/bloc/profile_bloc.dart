import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/features/profile/domain/usecases/profile_update_info.dart';
import 'package:chatty_app/features/profile/domain/usecases/profile_upload_image.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUpdateInfo _profileUpdateInfo;
  final ProfileUploadImage _profileUploadImage;
  final AppUserCubit _appUserCubit;

  ProfileBloc({
    required ProfileUpdateInfo profileUpdateInfo,
    required ProfileUploadImage profileUploadImage,
    required AppUserCubit appUserCubit,
  })  : _profileUpdateInfo = profileUpdateInfo,
        _profileUploadImage = profileUploadImage,
        _appUserCubit = appUserCubit,
        super(ProfileInitial()) {
    on<ProfileEvent>((_, emit) {
      emit(ProfileLoading());
    });
    on<ProfileUpdate>(_onProfileUpdateInfo);
    on<ProfileUpload>(_onProfileUploadImage);
  }

  void _onProfileUpdateInfo(
    ProfileUpdate event,
    Emitter<ProfileState> emit,
  ) async {
    final response = await _profileUpdateInfo.call(ProfileUpdateInfoParams(
      userId: event.userId,
      username: event.username,
      description: event.description,
      avatarUrl: event.avatarUrl,
    ));

    response.fold(
      (failure) => emit(EditFailure(failure.message)),
      (user) => _emitUpdateSuccess(user, emit),
    );
  }

  void _onProfileUploadImage(
    ProfileUpload event,
    Emitter<ProfileState> emit,
  ) async {
    final response = await _profileUploadImage(
      ProfileUploadImageParams(
        image: event.image,
        oldUrl: event.oldUrl,
      ),
    );

    response.fold(
      (failure) => emit(EditFailure(failure.message)),
      (imageUrl) => emit(
        UploadSuccess(imageUrl),
      ),
    );
  }

  void _emitUpdateSuccess(
    User user,
    Emitter<ProfileState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(UpdateSuccess(user));
  }
}
