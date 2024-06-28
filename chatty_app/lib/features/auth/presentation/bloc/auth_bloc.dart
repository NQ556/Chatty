import 'package:bloc/bloc.dart';
import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_get_current.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_reset_password.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_out.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final UserResetPassword _userResetPassword;
  final UserGetCurrent _userGetCurrentData;
  final AppUserCubit _appUserCubit;
  final UserSignOut _userSignOut;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required UserResetPassword userResetPassword,
    required UserGetCurrent userGetCurrentData,
    required AppUserCubit appUserCubit,
    required UserSignOut userSignOut,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _userResetPassword = userResetPassword,
        _userGetCurrentData = userGetCurrentData,
        _appUserCubit = appUserCubit,
        _userSignOut = userSignOut,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) {
      emit(AuthLoading());
    });
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthResetPassword>(_onAuthReset);
    on<AuthGetCurrentUserData>(_onGetCurrentUserData);
    on<AuthSignOut>(_onUserSignOut);
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userSignUp.call(
      UserSignUpParams(
        username: event.username,
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userSignIn.call(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthReset(
    AuthResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userResetPassword.call(
      UserResetPasswordParams(
        email: event.email,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(ResetSuccess()),
    );
  }

  void _onGetCurrentUserData(
    AuthGetCurrentUserData event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userGetCurrentData.call(NoParams());

    response.fold(
      (_) => emit(AuthGetUserFailure()),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onUserSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    final response = await _userSignOut.call(NoParams());

    response.fold(
      (failure) => emit(
        AuthFailure(failure.message),
      ),
      (_) => emit(
        SignOutSuccess(),
      ),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
