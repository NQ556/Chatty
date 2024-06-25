import 'package:bloc/bloc.dart';
import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) {
      emit(AuthLoading());
    });
    on<AuthSignUp>(_onAuthSignUp);
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

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    //_appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
