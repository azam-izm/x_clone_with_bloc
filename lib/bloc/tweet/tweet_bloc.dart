import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_clone_with_bloc/models/mock_data.dart';
import 'package:x_clone_with_bloc/models/tweet.dart';
import 'package:x_clone_with_bloc/models/comment.dart';
import 'package:equatable/equatable.dart';

part 'tweet_event.dart';
part 'tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  TweetBloc() : super(const TweetState(tweets: [])) {
    on<LoadTweets>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        await Future.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(tweets: mockTweets, isLoading: false));
      } catch (e) {
        emit(state.copyWith(error: e.toString(), isLoading: false));
      }
    });

    on<LikeTweet>((event, emit) {
      final updatedTweets = state.tweets.map((tweet) {
        if (tweet.id == event.tweetId) {
          return tweet.copyWith(
            isLiked: !tweet.isLiked,
            likes: tweet.isLiked ? tweet.likes - 1 : tweet.likes + 1,
          );
        }
        return tweet;
      }).toList();
      emit(state.copyWith(tweets: updatedTweets));
    });

    on<RetweetTweet>((event, emit) {
      final updatedTweets = state.tweets.map((tweet) {
        if (tweet.id == event.tweetId) {
          final isRetweeted = tweet.retweetedBy.contains(currentUser.id);
          final newRetweetedBy = isRetweeted
              ? tweet.retweetedBy.where((id) => id != currentUser.id).toList()
              : [...tweet.retweetedBy, currentUser.id];
          return tweet.copyWith(
            retweets: isRetweeted ? tweet.retweets - 1 : tweet.retweets + 1,
            retweetedBy: newRetweetedBy,
          );
        }
        return tweet;
      }).toList();
      emit(state.copyWith(tweets: updatedTweets));
    });

    on<QuoteTweet>((event, emit) {
      final originalTweet =
          state.tweets.firstWhere((t) => t.id == event.tweetId);
      final quoteTweet = Tweet(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        user: currentUser,
        content: event.quoteContent,
        timestamp: DateTime.now(),
        originalTweet: originalTweet,
        isQuoteTweet: true,
      );
      final updatedTweets = [quoteTweet, ...state.tweets];
      emit(state.copyWith(tweets: updatedTweets));
    });

    on<CommentTweet>((event, emit) {
      final updatedTweets = state.tweets.map((tweet) {
        if (tweet.id == event.tweetId) {
          final newComment = Comment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            user: currentUser,
            text: event.commentText,
            timestamp: DateTime.now(),
          );
          return tweet.copyWith(
            comments: [...tweet.comments, newComment],
            replies: tweet.replies + 1,
          );
        }
        return tweet;
      }).toList();
      emit(state.copyWith(tweets: updatedTweets));
    });

    on<AddTweet>((event, emit) {
      final updatedTweets = [event.tweet, ...state.tweets];
      emit(state.copyWith(tweets: updatedTweets));
    });

    on<DeleteTweet>((event, emit) {
      final updatedTweets =
          state.tweets.where((tweet) => tweet.id != event.tweetId).toList();
      emit(state.copyWith(tweets: updatedTweets));
    });

    on<RefreshTweets>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(tweets: mockTweets, isLoading: false));
    });
  }
}
