import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:timeago/timeago.dart' as timeago;

@immutable
class User extends Equatable {
  final String id;
  final String name;
  final String handle;
  final String bio;
  final String profileImage;
  final String bannerImage;
  final int followers;
  final int following;
  final bool isVerified;
  final DateTime joinDate;

  const User({
    required this.id,
    required this.name,
    required this.handle,
    required this.bio,
    required this.profileImage,
    this.bannerImage = '',
    this.followers = 0,
    this.following = 0,
    this.isVerified = false,
    required this.joinDate,
  });

  String get formattedJoinDate => 'Joined ${timeago.format(joinDate)}';

  @override
  List<Object?> get props => [
        id,
        name,
        handle,
        bio,
        profileImage,
        bannerImage,
        followers,
        following,
        isVerified,
        joinDate,
      ];
}
