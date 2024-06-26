import 'package:chatty_app/core/common/widgets/loader.dart';
import 'package:chatty_app/features/conversation/presentation/pages/conversation_page.dart';
import 'package:chatty_app/features/friends/presentation/pages/friends_page.dart';
import 'package:chatty_app/features/navigation/presentation/bloc/nav_bloc.dart';
import 'package:chatty_app/features/navigation/presentation/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(),
      body: BlocBuilder<NavBloc, NavState>(
        builder: (context, state) {
          print(state);
          if (state is ConversationState || state is NavInitial) {
            return ConversationPage();
          } else if (state is FriendsState) {
            return FriendsPage();
          }
          return Loader();
        },
      ),
    );
  }
}