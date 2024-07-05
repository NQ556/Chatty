import 'package:bloc/bloc.dart';
import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/domain/entities/user.dart';
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
      emit(AuthLoadingState());
    });
    on<SignUpEvent>(_onAuthSignUp);
    on<SignInEvent>(_onAuthSignIn);
    on<ResetPasswordEvent>(_onAuthReset);
    on<GetCurrentUserDataEvent>(_onGetCurrentUserData);
    on<SignOutEvent>(_onUserSignOut);
  }

  void _onAuthSignUp(
    SignUpEvent event,
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
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignIn(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userSignIn.call(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthReset(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userResetPassword.call(
      UserResetPasswordParams(
        email: event.email,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (_) => emit(ResetSuccessState()),
    );
  }

  Future<void> _onGetCurrentUserData(
    GetCurrentUserDataEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userGetCurrentData.call(NoParams());

    response.fold(
      (_) => emit(GetUserFailureState()),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onUserSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    final response = await _userSignOut.call(NoParams());

    response.fold(
      (failure) => emit(
        AuthFailureState(failure.message),
      ),
      (_) => emit(
        SignOutSuccessState(),
      ),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccessState(user));
  }
}
