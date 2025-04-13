part of 'follow_bloc.dart';

class FollowState {
  final Set<String> followStatus;

  FollowState(this.followStatus);

  FollowState copyWith({Set<String>? followStatus}) {
    return FollowState(followStatus ?? this.followStatus);
  }
}
