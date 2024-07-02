import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/core/common/functions/show_snackbar.dart';
import 'package:chatty_app/core/common/widgets/search_box.dart';
import 'package:chatty_app/core/utils/route_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/friends/presentation/bloc/discovery_bloc.dart';
import 'package:chatty_app/features/friends/presentation/widgets/user_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  final searchController = TextEditingController();
  final scrollController = ScrollController();
  List<User> users = [];
  bool canAdd = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);

    final state = context.read<DiscoveryBloc>().state;

    if (!(state is GetUsersSuccessState)) {
      _loadMoreUsers();
    }
  }

  @override
  void dispose() {
    super.dispose();

    searchController.dispose();
    scrollController.dispose();
  }

  void _onScroll() {
    final state = context.read<DiscoveryBloc>().state;
    if (scrollController.position.atEdge) {
      bool isBottom = scrollController.position.pixels != 0;
      if (isBottom && state is GetUsersSuccessState) {
        _loadMoreUsers(lastDocument: users.last.documentSnapshot);
      }
    }
  }

  void _loadMoreUsers({DocumentSnapshot? lastDocument}) {
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;

    context.read<DiscoveryBloc>().add(
          DiscoveryFriendsEvent(
            currentUserId: currentUser.id,
            limit: 6,
            lastDocument: lastDocument,
          ),
        );
  }

  void _onUserPressed(User user, int currentIndex) {
    canAdd = true;
    Navigator.pushNamed(
      context,
      Routes.profileRoute,
      arguments: UserDetailArguments(
        user: user,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<DiscoveryBloc, DiscoveryState>(
        listener: (context, state) {
          if (state is DiscoveryFailureState) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is GetUsersSuccessState || state is DiscoveryEmptyState) {
            if (state is GetUsersSuccessState) {
              users.addAll(state.users);
              print("IIIIIIIIIIIII");
              print(state.users.length);
            }
          } else if (state is AddFriendSuccessState && users.isNotEmpty) {
            users.clear();
            _loadMoreUsers();
          }

          return Column(
            children: [
              // Search
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: SearchBox(
                  hintText: StringManager.search,
                  textEditingController: searchController,
                ),
              ),

              //
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 30,
                      ),
                      child: UserDisplay(
                        user: users[index],
                        onTap: () {
                          _onUserPressed(users[index], index);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
