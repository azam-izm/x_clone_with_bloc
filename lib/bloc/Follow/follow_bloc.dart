import 'package:flutter_bloc/flutter_bloc.dart';
part 'follow_event.dart';
part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  FollowBloc() : super(FollowState({})) {
    on<ToggleFollowEvent>((event, emit) {
      final updatedSet = Set<String>.from(state.followStatus);

      updatedSet.contains(event.userId)
          ? updatedSet.remove(event.userId)
          : updatedSet.add(event.userId);

      emit(state.copyWith(followStatus: updatedSet));
    });
  }
}
