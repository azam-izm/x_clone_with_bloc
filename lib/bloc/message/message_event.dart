part of 'message_bloc.dart';

abstract class MessageEvent {}

class LoadMessages extends MessageEvent {
  final String userId;
  LoadMessages(this.userId);
}

class SendMessage extends MessageEvent {
  final String text;
  SendMessage(this.text);
}
