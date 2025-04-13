import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_clone_with_bloc/bloc/tweet/tweet_bloc.dart';
import 'package:x_clone_with_bloc/models/mock_data.dart';
import 'package:x_clone_with_bloc/models/user.dart';
import 'package:x_clone_with_bloc/widgets/tweet_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = currentUser;

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search,
                  color: isDark ? Colors.white : Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert,
                  color: isDark ? Colors.white : Colors.black),
              onPressed: () {},
            ),
          ],
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          elevation: 1,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(user.bannerImage.isNotEmpty
                              ? user.bannerImage
                              : 'https://picsum.photos/800/200'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage:
                                    NetworkImage(user.profileImage),
                              ),
                              const Spacer(),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: BorderSide(
                                      color:
                                          isDark ? Colors.white : Colors.black),
                                ),
                                child: Text('Edit profile',
                                    style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Text(user.name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  )),
                              if (user.isVerified)
                                const Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Icon(Icons.verified,
                                      color: Colors.blue, size: 20),
                                ),
                            ],
                          ),
                          Text('@${user.handle}',
                              style: TextStyle(color: Colors.grey.shade600)),
                          const SizedBox(height: 8),
                          Text(user.bio, style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 16, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text('Punjab, Pakistan',
                                  style:
                                      TextStyle(color: Colors.grey.shade600)),
                              const SizedBox(width: 16),
                              Icon(Icons.calendar_today,
                                  size: 16, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(user.formattedJoinDate,
                                  style:
                                      TextStyle(color: Colors.grey.shade600)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Text('${user.following} Following',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 16),
                              Text('${user.followers} Followers',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      child: TabBar(
                        isScrollable: true,
                        tabs: const [
                          Tab(text: 'Posts'),
                          Tab(text: 'Replies'),
                          Tab(text: 'Highlights'),
                          Tab(text: 'Articles'),
                          Tab(text: 'Media'),
                          Tab(text: 'Likes'),
                        ],
                        indicatorColor: Colors.blue,
                        labelColor: isDark ? Colors.white : Colors.grey[900],
                        unselectedLabelColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildPostsTab(user, isDark),
              _buildEmptyTab('Replies will appear here', isDark),
              _buildEmptyTab('Highlights will appear here', isDark),
              _buildEmptyTab('Articles will appear here', isDark),
              _buildEmptyTab('Media will appear here', isDark),
              _buildEmptyTab('Likes will appear here', isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostsTab(User user, bool isDark) {
    return BlocBuilder<TweetBloc, TweetState>(
      builder: (context, state) {
        final userTweets = state.tweets
            .where(
                (t) => t.user.id == user.id || t.retweetedBy.contains(user.id))
            .toList();
        return ListView.builder(
          itemCount: userTweets.length,
          itemBuilder: (context, index) => TweetWidget(
            tweet: userTweets[index],
            showRetweetLabel: false,
          ),
        );
      },
    );
  }

  Widget _buildEmptyTab(String message, bool isDark) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: isDark ? Colors.grey[400] : Colors.grey[600],
          fontSize: 16,
        ),
      ),
    );
  }
}
