import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:chatty_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chatty_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_get_current.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_reset_password.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:chatty_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chatty_app/features/navigation/presentation/bloc/nav_bloc.dart';
import 'package:chatty_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  getIt.registerLazySingleton(() => firebaseAuth);
  getIt.registerLazySingleton(() => firebaseFirestore);
  getIt.registerLazySingleton(() => AppUserCubit());
  getIt.registerLazySingleton(() => NavBloc());
}

void _initAuth() {
  getIt.registerFactory<AuthDataSource>(
    () => AuthDataSourceImpl(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => UserSignUp(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => UserSignIn(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => UserResetPassword(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => UserGetCurrent(
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => AuthBloc(
      userSignUp: getIt(),
      userSignIn: getIt(),
      userResetPassword: getIt(),
      userGetCurrentData: getIt(),
      appUserCubit: getIt(),
    ),
  );
}
