import 'package:bloc/bloc.dart';
import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_reset_password.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final UserResetPassword _userResetPassword;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required UserResetPassword userResetPassword,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _userResetPassword = userResetPassword,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) {
      emit(AuthLoading());
    });
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthResetPassword>(_onAuthReset);
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

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    //_appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
