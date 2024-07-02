import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:chatty_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chatty_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_get_current.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_reset_password.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_out.dart';
import 'package:chatty_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:chatty_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chatty_app/features/friends/data/datasources/discovery_datasource.dart';
import 'package:chatty_app/features/friends/data/repositories/discovery_repository_impl.dart';
import 'package:chatty_app/features/friends/domain/repositories/discovery_repository.dart';
import 'package:chatty_app/features/friends/domain/usecases/discovery_new_friends.dart';
import 'package:chatty_app/features/friends/domain/usecases/friend_add_friend.dart';
import 'package:chatty_app/features/friends/domain/usecases/friend_get_friends.dart';
import 'package:chatty_app/features/friends/domain/usecases/friend_remove_friend.dart';
import 'package:chatty_app/features/friends/presentation/bloc/discovery_bloc.dart';
import 'package:chatty_app/features/navigation/presentation/bloc/nav_bloc.dart';
import 'package:chatty_app/features/profile/data/datasources/profile_datasource.dart';
import 'package:chatty_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:chatty_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:chatty_app/features/profile/domain/usecases/profile_update_info.dart';
import 'package:chatty_app/features/profile/domain/usecases/profile_upload_image.dart';
import 'package:chatty_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:chatty_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initProfile();
  _initDiscovery();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  getIt.registerLazySingleton(() => firebaseAuth);
  getIt.registerLazySingleton(() => firebaseFirestore);
  getIt.registerLazySingleton(() => firebaseStorage);
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

  getIt.registerFactory(
    () => UserSignOut(
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
      userSignOut: getIt(),
    ),
  );
}

void _initProfile() {
  getIt.registerFactory<ProfileDataSource>(
    () => ProfileDataSourceImpl(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerFactory<ProfileRepository>(
    () => ProfileRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => ProfileUpdateInfo(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => ProfileUploadImage(
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => ProfileBloc(
      profileUpdateInfo: getIt(),
      profileUploadImage: getIt(),
      appUserCubit: getIt(),
    ),
  );
}

void _initDiscovery() {
  getIt.registerFactory<DiscoveryDatasource>(
    () => DiscoveryDataSourceImpl(
      getIt(),
    ),
  );

  getIt.registerFactory<DiscoveryRepository>(
    () => DiscoveryRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => DiscoveryNewFriends(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => FriendAddFriend(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => FriendGetFriends(
      getIt(),
    ),
  );

  getIt.registerFactory(
    () => FriendRemoveFriend(
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => DiscoveryBloc(
      discoveryShowNewFriends: getIt(),
      friendAddFriend: getIt(),
      friendGetFriends: getIt(),
      friendRemoveFriend: getIt(),
    ),
  );
}
