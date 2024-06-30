import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavInitial()) {
    on<NavConversationEvent>((_, emit) {
      emit(NavConversationState());
    });
    on<NavFriendsEvent>((_, emit) {
      emit(NavFriendsState());
    });
    on<NavDiscoveryEvent>((_, emit) {
      emit(NavDiscoveryState());
    });
    on<NavProfileEvent>((_, emit) {
      emit(NavProfileState());
    });
  }
}
