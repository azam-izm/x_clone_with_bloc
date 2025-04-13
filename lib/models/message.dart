import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'user.dart';

@immutable
class Message extends Equatable {
  final User sender;
  final String text;
  final DateTime time;
  final bool isRead;

  const Message({
    required this.sender,
    required this.text,
    required this.time,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [
        sender,
        text,
        time,
        isRead,
      ];
}
