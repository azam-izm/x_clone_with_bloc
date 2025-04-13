import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:x_clone_with_bloc/bloc/tweet/tweet_bloc.dart';
import 'package:x_clone_with_bloc/models/tweet.dart';
import 'package:x_clone_with_bloc/models/mock_data.dart';
import 'package:x_clone_with_bloc/screens/tweet_detail_screen.dart';

class TweetWidget extends StatelessWidget {
  final Tweet tweet;
  final bool showRetweetLabel;

  const TweetWidget({
    super.key,
    required this.tweet,
    this.showRetweetLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final isRetweetedByCurrentUser = tweet.retweetedBy.contains(currentUser.id);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TweetDetailScreen(tweet: tweet),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showRetweetLabel &&
                isRetweetedByCurrentUser &&
                !tweet.isQuoteTweet)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.repeat, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${currentUser.name} Retweeted',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                  ],
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(tweet.user.profileImage),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            tweet.user.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (tweet.user.isVerified)
                            const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(Icons.verified,
                                  color: Colors.blue, size: 16),

                          const SizedBox(width: 4),
                          Text(
                            '@${tweet.user.handle}',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '· ${timeago.format(tweet.timestamp)}',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(tweet.content),
                      if (tweet.isQuoteTweet && tweet.originalTweet != null)
                        _buildQuotedTweet(context, tweet.originalTweet!),
                      if (tweet.imageUrls.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            tweet.imageUrls.first,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      _buildActionButtons(context),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuotedTweet(BuildContext context, Tweet originalTweet) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage(originalTweet.user.profileImage),
              ),
              const SizedBox(width: 8),
              Text(
                originalTweet.user.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(width: 4),
              Text(
                '@${originalTweet.user.handle}',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(originalTweet.content, style: const TextStyle(fontSize: 12)),
          if (originalTweet.imageUrls.isNotEmpty) ...[
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                originalTweet.imageUrls.first,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(Icons.chat_bubble_outline, tweet.replies.toString()),
        _buildRetweetButton(context),
        _buildLikeButton(context),
        _buildActionButton(Icons.share, ''),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        if (count.isNotEmpty) ...[
          const SizedBox(width: 4),
          Text(count, style: const TextStyle(color: Colors.grey)),
        ],
      ],
    );
  }

  Widget _buildLikeButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<TweetBloc>().add(LikeTweet(tweet.id)),
      child: Row(
        children: [
          Icon(
            tweet.isLiked ? Icons.favorite : Icons.favorite_border,
            color: tweet.isLiked ? Colors.red : Colors.grey,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(
            tweet.likes.toString(),
            style: TextStyle(color: tweet.isLiked ? Colors.red : Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildRetweetButton(BuildContext context) {
    final isRetweeted = tweet.retweetedBy.contains(currentUser.id);

    return GestureDetector(
      onTap: () => _showRetweetDialog(context),
      child: Row(
        children: [
          Icon(
            Icons.repeat,
            color: isRetweeted ? Colors.green : Colors.grey,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(
            tweet.retweets.toString(),
            style: TextStyle(color: isRetweeted ? Colors.green : Colors.grey),
          ),
        ],
      ),
    );
  }

  void _showRetweetDialog(BuildContext context) {
    final quoteController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.repeat),
                title: const Text('Retweet'),
                onTap: () {
                  context.read<TweetBloc>().add(RetweetTweet(tweet.id));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.format_quote),
                title: const Text('Quote Tweet'),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Quote Tweet'),
                      content: TextField(
                        controller: quoteController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: 'Add your comment',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            if (quoteController.text.trim().isNotEmpty) {
                              context.read<TweetBloc>().add(
                                    QuoteTweet(
                                        tweet.id, quoteController.text.trim()),
                                  );
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Tweet'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
