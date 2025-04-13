import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'user.dart';

@immutable
class Comment extends Equatable {
  final String id;
  final User user;
  final String text;
  final DateTime timestamp;

  const Comment({
    required this.id,
    required this.user,
    required this.text,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, user, text, timestamp];
}
