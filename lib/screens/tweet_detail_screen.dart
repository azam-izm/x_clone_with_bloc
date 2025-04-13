import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:x_clone_with_bloc/bloc/tweet/tweet_bloc.dart';
import 'package:x_clone_with_bloc/models/tweet.dart';
import 'package:x_clone_with_bloc/models/comment.dart';
import 'package:x_clone_with_bloc/widgets/tweet_widget.dart';

class TweetDetailScreen extends StatelessWidget {
  final Tweet tweet;

  const TweetDetailScreen({super.key, required this.tweet});

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Post'),
      ),
      body: BlocBuilder<TweetBloc, TweetState>(
        builder: (context, state) {
          final updatedTweet = state.tweets.firstWhere((t) => t.id == tweet.id);
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TweetWidget(tweet: updatedTweet, showRetweetLabel: true),
                      const Divider(),
                      if (updatedTweet.comments.isNotEmpty)
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: updatedTweet.comments.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final comment = updatedTweet.comments[index];
                            return _buildComment(comment);
                          },
                        ),
                      if (updatedTweet.comments.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('No comments yet.'),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: const InputDecoration(
                          hintText: 'Post your reply',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (commentController.text.trim().isNotEmpty) {
                          context.read<TweetBloc>().add(
                                CommentTweet(
                                    tweet.id, commentController.text.trim()),
                              );
                          commentController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Reply'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildComment(Comment comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(comment.user.profileImage),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '@${comment.user.handle}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '· ${timeago.format(comment.timestamp)}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(comment.text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
