import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_clone_with_bloc/bloc/theme/theme_bloc.dart';
import 'package:x_clone_with_bloc/bloc/tweet/tweet_bloc.dart';
import 'package:x_clone_with_bloc/models/mock_data.dart';
import 'package:x_clone_with_bloc/screens/profile_screen.dart';
import 'package:x_clone_with_bloc/widgets/tweet_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(currentUser.profileImage),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          ),
        ),
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
            return IconButton(
              icon: Icon(state.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => context.read<ThemeBloc>().add(ToggleTheme()),
            );
          }),
        ],
      ),
      body: BlocBuilder<TweetBloc, TweetState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<TweetBloc>().add(RefreshTweets());
              await Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.separated(
              itemCount: state.tweets.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.grey[800]),
              itemBuilder: (context, index) => TweetWidget(
                tweet: state.tweets[index],
                showRetweetLabel: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
