import 'package:chatty_app/features/chat/presentation/pages/conversation_page.dart';
import 'package:chatty_app/features/friends/presentation/pages/discovery_page.dart';
import 'package:chatty_app/features/friends/presentation/pages/friends_page.dart';
import 'package:chatty_app/features/navigation/presentation/bloc/nav_bloc.dart';
import 'package:chatty_app/features/navigation/presentation/widgets/bottom_nav.dart';
import 'package:chatty_app/features/profile/presentation/pages/profile_page.dart';
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
          if (state is NavConversationState || state is NavInitial) {
            return ConversationPage();
          } else if (state is NavFriendsState) {
            return FriendsPage();
          } else if (state is NavDiscoveryState) {
            return DiscoveryPage();
          } else if (state is NavProfileState) {
            return ProfilePage();
          }
          return ConversationPage();
        },
      ),
    );
  }
}
