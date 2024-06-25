import 'package:chatty_app/core/utils/route_manager.dart';
import 'package:chatty_app/core/utils/theme_manager.dart';
import 'package:chatty_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chatty_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:chatty_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => getIt<AuthBloc>(),
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

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      home: SignInPage(),
      theme: getApplicationTheme(),
    );
  }
}
