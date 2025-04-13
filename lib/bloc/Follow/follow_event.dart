part of 'follow_bloc.dart';

abstract class FollowEvent {}

class ToggleFollowEvent extends FollowEvent {
  final String userId;
  ToggleFollowEvent(this.userId);
}
