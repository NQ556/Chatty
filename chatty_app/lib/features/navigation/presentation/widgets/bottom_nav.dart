import 'package:chatty_app/core/utils/asset_manager.dart';
import 'package:chatty_app/features/navigation/presentation/bloc/nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    final navBloc = context.read<NavBloc>();
    navBloc.add(NavConversation());

    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            switch (index) {
              case 0:
                _currentIndex = 0;
                navBloc.add(NavConversation());
                break;
              case 1:
                _currentIndex = 1;
                navBloc.add(NavFriends());
                break;
              case 2:
                _currentIndex = 2;
                navBloc.add(NavDiscovery());
                break;
              case 3:
                _currentIndex = 3;
                navBloc.add(NavProfile());
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetManager.chatIcon),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetManager.usersIcon),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetManager.searchIcon),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetManager.userIcon),
              label: "",
            ),
          ],
        );
      },
    );
  }
}
