// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_clone_with_bloc/bloc/tweet/tweet_bloc.dart';
import 'package:x_clone_with_bloc/models/mock_data.dart';
import 'package:x_clone_with_bloc/models/tweet.dart';

class ComposeTweetScreen extends StatefulWidget {
  const ComposeTweetScreen({super.key});

  @override
  State<ComposeTweetScreen> createState() => _ComposeTweetScreenState();
}

class _ComposeTweetScreenState extends State<ComposeTweetScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isPostEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updatePostButtonState);
  }

  @override
  void dispose() {
    _controller.removeListener(_updatePostButtonState);
    _controller.dispose();
    super.dispose();
  }

  void _updatePostButtonState() {
    setState(() {
      _isPostEnabled = _controller.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: _isPostEnabled ? _postTweet : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Post'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(currentUser.profileImage),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "What's happening?",
                      border: InputBorder.none,
                    ),
                    autofocus: true,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.image, color: Colors.blue),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.gif, color: Colors.blue),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.poll, color: Colors.blue),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions, color: Colors.blue),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _postTweet() {
    final newTweet = Tweet(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      user: currentUser,
      content: _controller.text.trim(),
      timestamp: DateTime.now(),
    );

    context.read<TweetBloc>().add(AddTweet(newTweet));
    Navigator.pop(context);
  }
}
