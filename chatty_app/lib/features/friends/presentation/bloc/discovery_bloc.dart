import 'package:bloc/bloc.dart';
import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:chatty_app/features/friends/domain/usecases/discovery_new_friends.dart';
import 'package:chatty_app/features/friends/domain/usecases/friend_add_friend.dart';
import 'package:chatty_app/features/friends/domain/usecases/friend_get_friends.dart';
import 'package:chatty_app/features/friends/domain/usecases/friend_remove_friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  final DiscoveryNewFriends _discoveryShowNewFriends;
  final FriendAddFriend _friendAddFriend;
  final FriendGetFriends _friendGetFriends;
  final FriendRemoveFriend _friendRemoveFriend;

  DiscoveryBloc({
    required DiscoveryNewFriends discoveryShowNewFriends,
    required FriendAddFriend friendAddFriend,
    required FriendGetFriends friendGetFriends,
    required FriendRemoveFriend friendRemoveFriend,
  })  : _discoveryShowNewFriends = discoveryShowNewFriends,
        _friendAddFriend = friendAddFriend,
        _friendGetFriends = friendGetFriends,
        _friendRemoveFriend = friendRemoveFriend,
        super(DiscoveryInitial()) {
    on<DiscoveryEvent>((_, emit) {
      emit(DiscoveryLoadingState());
    });
    on<DiscoveryFriendsEvent>(_onDiscoverFriends);
    on<AddFriendEvent>(_onAddFriend);
    on<GetFriendsEvent>(_onGetFriends);
    on<RemoveFriendEvent>(_onRemoveFriend);
    on<ReloadEvent>((_, emit) {
      emit(NoState());
    });
  }

  void _onDiscoverFriends(
    DiscoveryFriendsEvent event,
    Emitter<DiscoveryState> emit,
  ) async {
    final response = await _discoveryShowNewFriends.call(
      DiscoveryNewFriendsParams(
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
        AddFriendSuccessState(event.friendUser),
      ),
    );
  }

  void _onGetFriends(
    GetFriendsEvent event,
    Emitter<DiscoveryState> emit,
  ) async {
    final response = await _friendGetFriends.call(
      FriendGetFriendsParams(
        currentUserId: event.currentUserId,
        limit: event.limit,
        lastDocument: event.lastDocument,
      ),
    );

    response.fold(
      (failure) => emit(DiscoveryFailureState(failure.message)),
      (users) => _emitGetFriendsSucces(users, emit),
    );
  }

  void _emitDiscoverySucces(
    List<User> users,
    Emitter<DiscoveryState> emit,
  ) {
    if (users.isEmpty) {
      emit(DiscoveryEmptyState());
    } else {
      emit(GetUsersSuccessState(users));
    }
  }

  void _emitGetFriendsSucces(
    List<User> users,
    Emitter<DiscoveryState> emit,
  ) {
    if (users.isEmpty) {
      emit(DiscoveryEmptyState());
    } else {
      emit(GetFriendsSuccessState(users));
    }
  }

  void _onRemoveFriend(
    RemoveFriendEvent event,
    Emitter<DiscoveryState> emit,
  ) async {
    final response = await _friendRemoveFriend.call(
      FriendRemoveFriendParams(
        currentUserId: event.currentUserId,
        friendId: event.friendId,
      ),
    );

    response.fold(
      (failure) => emit(DiscoveryFailureState(failure.message)),
      (_) => emit(
        RemoveFriendSuccessState(event.friendUser),
      ),
    );
  }
}
