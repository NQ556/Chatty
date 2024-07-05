import 'package:chatty_app/core/common/bloc/online_status_bloc.dart';
import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/utils/route_manager.dart';
import 'package:chatty_app/core/utils/theme_manager.dart';
import 'package:chatty_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chatty_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:chatty_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chatty_app/features/friends/presentation/bloc/discovery_bloc.dart';
import 'package:chatty_app/features/navigation/presentation/bloc/nav_bloc.dart';
import 'package:chatty_app/features/navigation/presentation/pages/home_page.dart';
import 'package:chatty_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:chatty_app/init_dependencies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => getIt<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => getIt<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => getIt<NavBloc>(),
      ),
      BlocProvider(
        create: (_) => getIt<ProfileBloc>(),
      ),
      BlocProvider(
        create: (_) => getIt<DiscoveryBloc>(),
      ),
      BlocProvider(
        create: (_) => getIt<ChatBloc>(),
      ),
      BlocProvider(
        create: (_) => getIt<OnlineStatusBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<AuthBloc>().add(GetCurrentUserDataEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      context.read<OnlineStatusBloc>().add(
            UpdateOnlineStatusEvent(
              userId: currentUser.id,
              isOnline: false,
            ),
          );
    } else if (state == AppLifecycleState.resumed) {
      context.read<OnlineStatusBloc>().add(
            UpdateOnlineStatusEvent(
              userId: currentUser.id,
              isOnline: true,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      home: StreamBuilder<User?>(
        stream: GetIt.instance<FirebaseAuth>().authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return SignInPage();
          }
        },
      ),
      theme: getApplicationTheme(),
    );
  }
}
