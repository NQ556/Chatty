import 'package:bloc/bloc.dart';
import 'package:chatty_app/core/common/domain/usecases/status_update.dart';
import 'package:meta/meta.dart';

part 'online_status_event.dart';
part 'online_status_state.dart';

class OnlineStatusBloc extends Bloc<OnlineStatusEvent, OnlineStatusState> {
  final StatusUpdate _statusUpdate;

  OnlineStatusBloc({
    required StatusUpdate statusUpdate,
  })  : _statusUpdate = statusUpdate,
        super(OnlineStatusInitial()) {
    on<UpdateOnlineStatusEvent>(_updateOnlineStatus);
  }

  Future<void> _updateOnlineStatus(
    UpdateOnlineStatusEvent event,
    Emitter<OnlineStatusState> emit,
  ) async {
    final response = await _statusUpdate.call(
      StatusUpdateParams(
        userId: event.userId,
        isOnline: event.isOnline,
      ),
    );

    response.fold(
      (failure) => emit(StatusFailureState(failure.message)),
      (_) => emit(StatusUpdatedState(event.isOnline)),
    );
  }
}
