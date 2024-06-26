import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavInitial()) {
    on<NavConversation>((_, emit) {
      emit(ConversationState());
    });
    on<NavFriends>((_, emit) {
      emit(FriendsState());
    });
    on<NavDiscovery>((_, emit) {
      emit(DiscoveryState());
    });
    on<NavProfile>((_, emit) {
      emit(ProfileState());
    });
  }
}
