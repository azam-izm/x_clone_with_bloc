// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_clone_with_bloc/bloc/Follow/follow_bloc.dart';
import 'package:x_clone_with_bloc/models/mock_data.dart';
import 'package:x_clone_with_bloc/models/user.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => FollowBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              style: TextStyle(
                  color: isDark ? const Color(0xff1d1b1b) : Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,
                    color: isDark ? Colors.grey[400] : Colors.grey[600]),
                hintText: 'Search X',
                hintStyle: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Trending now',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18)),
            ),
            _buildTrendingItem(
                topic: 'Flutter', posts: '125K posts', isDark: isDark),
            _buildTrendingItem(
                topic: 'Dart', posts: '42K posts', isDark: isDark),
            _buildTrendingItem(
                topic: 'Programming', posts: '89K posts', isDark: isDark),
            _buildTrendingItem(
                topic: 'Tech News', posts: '56K posts', isDark: isDark),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Suggested accounts',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18)),
            ),
            _buildUserItem(user: mockUsers[0], isDark: isDark),
            _buildUserItem(user: mockUsers[2], isDark: isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingItem({
    required String topic,
    required String posts,
    required bool isDark,
  }) {
    return ListTile(
      leading: Icon(Icons.trending_up,
          color: isDark ? Colors.blue[200] : Colors.blue),
      title: Text(topic,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          )),
      subtitle: Text(posts,
          style:
              TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600])),
      trailing: Icon(Icons.more_vert,
          color: isDark ? Colors.grey[400] : Colors.grey[600]),
    );
  }

  Widget _buildUserItem({
    required User user,
    required bool isDark,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.profileImage),
      ),
      title: Row(
        children: [
          Text(user.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              )),
          if (user.isVerified)
            const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(Icons.verified, color: Colors.blue, size: 16)),
        ],
      ),
      subtitle: Text('@${user.handle}',
          style:
              TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600])),
      trailing: BlocBuilder<FollowBloc, FollowState>(
        builder: (context, state) {
          final isFollowing = state.followStatus.contains(user.id);
          return GestureDetector(
            onTap: () {
              context.read<FollowBloc>().add(ToggleFollowEvent(user.id));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isFollowing
                    ? (isDark ? Colors.grey[700] : Colors.grey[300])
                    : (isDark ? Colors.blue[800] : Colors.blue),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isFollowing ? 'Following' : 'Follow',
                style: TextStyle(
                  color: isFollowing
                      ? (isDark ? Colors.white : Colors.black)
                      : Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
