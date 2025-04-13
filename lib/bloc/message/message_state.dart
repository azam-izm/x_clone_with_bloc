part of 'message_bloc.dart';

class MessageState extends Equatable {
  final List<dynamic> messages;
  final bool isLoading;

  const MessageState({
    required this.messages,
    this.isLoading = false,
  });

  MessageState copyWith({
    List<dynamic>? messages,
    bool? isLoading,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading];
}
