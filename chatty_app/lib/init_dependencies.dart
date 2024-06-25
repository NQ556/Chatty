import 'package:chatty_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:chatty_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chatty_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:chatty_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chatty_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  getIt.registerLazySingleton(() => firebaseAuth);
  getIt.registerLazySingleton(() => firebaseDatabase);
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

  getIt.registerLazySingleton(
    () => AuthBloc(
      userSignUp: getIt(),
    ),
  );
}
