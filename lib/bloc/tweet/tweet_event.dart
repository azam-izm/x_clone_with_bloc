part of 'tweet_bloc.dart';

abstract class TweetEvent {}

class LoadTweets extends TweetEvent {}

class LikeTweet extends TweetEvent {
  final String tweetId;
  LikeTweet(this.tweetId);
}

class RetweetTweet extends TweetEvent {
  final String tweetId;
  RetweetTweet(this.tweetId);
}

class QuoteTweet extends TweetEvent {
  final String tweetId;
  final String quoteContent;
  QuoteTweet(this.tweetId, this.quoteContent);
}

class CommentTweet extends TweetEvent {
  final String tweetId;
  final String commentText;
  CommentTweet(this.tweetId, this.commentText);
}

class AddTweet extends TweetEvent {
  final Tweet tweet;
  AddTweet(this.tweet);
}

class DeleteTweet extends TweetEvent {
  final String tweetId;
  DeleteTweet(this.tweetId);
}

class RefreshTweets extends TweetEvent {}
