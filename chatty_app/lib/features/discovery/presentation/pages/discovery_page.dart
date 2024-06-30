import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/core/common/functions/show_snackbar.dart';
import 'package:chatty_app/core/common/widgets/loader.dart';
import 'package:chatty_app/core/common/widgets/search_box.dart';
import 'package:chatty_app/features/discovery/presentation/bloc/discovery_bloc.dart';
import 'package:chatty_app/features/discovery/presentation/widgets/user_display.dart';
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
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _loadMoreUsers();
  }

  @override
  void dispose() {
    super.dispose();

    searchController.dispose();
  }

  void _loadMoreUsers({DocumentSnapshot? lastDocument}) {
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;

    context.read<DiscoveryBloc>().add(
          ShowFriendsEvent(
            currentUserId: currentUser.id,
            limit: 1,
            lastDocument: lastDocument,
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
          if (state is DiscoveryLoadingState) {
            return Loader();
          } else if (state is DiscoverySuccessState ||
              state is DiscoveryEmptyState) {
            if (state is DiscoverySuccessState) {
              users += state.users;
            }

            return NotificationListener(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    state is DiscoverySuccessState) {
                  _loadMoreUsers(
                    lastDocument: users.last.documentSnapshot,
                  );
                }

                return false;
              },
              child: Column(
                children: [
                  // Search
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: SearchBox(
                      hintText: "Search",
                      textEditingController: searchController,
                    ),
                  ),

                  //
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 30,
                          ),
                          child: UserDisplay(
                            user: users[index],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
