import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'user.dart';
import 'comment.dart';

@immutable
class Tweet extends Equatable {
  final String id;
  final User user;
  final String content;
  final DateTime timestamp;
  final List<String> imageUrls;
  final int likes;
  final int retweets;
  final int replies;
  final bool isLiked;
  final List<String> retweetedBy;
  final Tweet? originalTweet;
  final bool isQuoteTweet;
  final List<Comment> comments; 

  const Tweet({
    required this.id,
    required this.user,
    required this.content,
    required this.timestamp,
    this.imageUrls = const [],
    this.likes = 0,
    this.retweets = 0,
    this.replies = 0,
    this.isLiked = false,
    this.retweetedBy = const [],
    this.originalTweet,
    this.isQuoteTweet = false,
    this.comments = const [],
  });

  Tweet copyWith({
    String? id,
    User? user,
    String? content,
    DateTime? timestamp,
    List<String>? imageUrls,
    int? likes,
    int? retweets,
    int? replies,
    bool? isLiked,
    List<String>? retweetedBy,
    Tweet? originalTweet,
    bool? isQuoteTweet,
    List<Comment>? comments,
  }) {
    return Tweet(
      id: id ?? this.id,
      user: user ?? this.user,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      imageUrls: imageUrls ?? this.imageUrls,
      likes: likes ?? this.likes,
      retweets: retweets ?? this.retweets,
      replies: replies ?? this.replies,
      isLiked: isLiked ?? this.isLiked,
      retweetedBy: retweetedBy ?? this.retweetedBy,
      originalTweet: originalTweet ?? this.originalTweet,
      isQuoteTweet: isQuoteTweet ?? this.isQuoteTweet,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object?> get props => [
        id,
        user,
        content,
        timestamp,
        imageUrls,
        likes,
        retweets,
        replies,
        isLiked,
        retweetedBy,
        originalTweet,
        isQuoteTweet,
        comments,
      ];
}
