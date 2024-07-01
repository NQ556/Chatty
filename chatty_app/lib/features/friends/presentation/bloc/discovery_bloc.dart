import 'package:bloc/bloc.dart';
import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/features/friends/domain/usecases/discovery_show_new_friends.dart';
import 'package:chatty_app/features/friends/domain/usecases/friend_add_friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  final DiscoveryShowNewFriends _discoveryShowNewFriends;
  final FriendAddFriend _friendAddFriend;

  DiscoveryBloc({
    required DiscoveryShowNewFriends discoveryShowNewFriends,
    required FriendAddFriend friendAddFriend,
  })  : _discoveryShowNewFriends = discoveryShowNewFriends,
        _friendAddFriend = friendAddFriend,
        super(DiscoveryInitial()) {
    on<DiscoveryEvent>((_, emit) {
      emit(DiscoveryLoadingState());
    });
    on<ShowFriendsEvent>(_onShowNewFriends);
    on<AddFriendEvent>(_onAddFriend);
  }

  void _onShowNewFriends(
    ShowFriendsEvent event,
    Emitter<DiscoveryState> emit,
  ) async {
    final response = await _discoveryShowNewFriends.call(
      DiscoveryShowNewFriendsParams(
        currentUserId: event.currentUserId,
        limit: event.limit,
        lastDocument: event.lastDocument,
      ),
    );

    response.fold(
      (failure) => emit(DiscoveryFailureState(failure.message)),
      (users) => _emitDiscoverySucces(users, emit),
    );
  }

  void _onAddFriend(
    AddFriendEvent event,
    Emitter<DiscoveryState> emit,
  ) async {
    final response = await _friendAddFriend.call(
      FriendAddFriendParams(
        currentUserId: event.currentUserId,
        friendId: event.friendId,
      ),
    );

    response.fold(
      (failure) => emit(DiscoveryFailureState(failure.message)),
      (_) => emit(
        AddFriendSuccessState(event.currentIndex),
      ),
    );
  }

  void _emitDiscoverySucces(
    List<User> users,
    Emitter<DiscoveryState> emit,
  ) {
    if (users.isEmpty) {
      emit(DiscoveryEmptyState());
    } else {
      emit(DiscoverySuccessState(users));
    }
  }
}
