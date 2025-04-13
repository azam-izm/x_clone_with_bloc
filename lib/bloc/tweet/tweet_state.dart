part of 'tweet_bloc.dart';

class TweetState extends Equatable {
  final List<Tweet> tweets;
  final bool isLoading;
  final String? error;

  const TweetState({
    required this.tweets,
    this.isLoading = false,
    this.error,
  });

  TweetState copyWith({
    List<Tweet>? tweets,
    bool? isLoading,
    String? error,
  }) {
    return TweetState(
      tweets: tweets ?? this.tweets,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        tweets,
        isLoading,
        error,
      ];
}