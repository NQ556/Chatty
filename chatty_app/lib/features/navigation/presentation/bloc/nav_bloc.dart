import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavInitial()) {
    on<NavConversation>((_, emit) {
      emit(NavConversationState());
    });
    on<NavFriends>((_, emit) {
      emit(NavFriendsState());
    });
    on<NavDiscovery>((_, emit) {
      emit(NavDiscoveryState());
    });
    on<NavProfile>((_, emit) {
      emit(NavProfileState());
    });
  }
}
