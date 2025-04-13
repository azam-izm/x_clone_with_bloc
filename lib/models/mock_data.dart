import 'package:x_clone_with_bloc/models/message.dart';

import 'user.dart';
import 'tweet.dart';

final List<User> mockUsers = [
  User(
    id: '2',
    name: 'Elon Musk',
    handle: 'elonmusk',
    bio: 'Let\'s go to Mars',
    profileImage: 'https://picsum.photos/201',
    isVerified: true,
    joinDate: DateTime(2022, 3, 10),
  ),
  currentUser,
  User(
    id: '3',
    name: 'Tech News',
    handle: 'technews',
    bio: 'Latest in technology',
    profileImage: 'https://picsum.photos/202',
    joinDate: DateTime(2021, 5, 15),
    isVerified: true,
  ),
  User(
    id: '4',
    name: 'Flutter Tips',
    handle: 'fluttertips',
    bio: 'Daily Flutter tips',
    profileImage: 'https://picsum.photos/203',
    joinDate: DateTime(2022, 3, 10),
  ),
];

final List<Tweet> mockTweets = [
  Tweet(
    id: '1',
    user: mockUsers[3],
    content: 'Flutter 3.0 is out with amazing new features!',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    likes: 243,
    retweets: 56,
    replies: 12,
    retweetedBy: const [],
    comments: const [],
  ),
  Tweet(
    id: '2',
    user: mockUsers[0],
    content:
        'When something is important enough, you do it even if the odds are not in your favour.',
    timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    likes: 952,
    retweets: 526,
    replies: 276,
    retweetedBy: const [],
    comments: const [],
  ),
  Tweet(
    id: '3',
    user: currentUser,
    content: 'Just built a complete X clone with Flutter in a single file!',
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    likes: 542,
    retweets: 124,
    replies: 43,
    imageUrls: const ['https://picsum.photos/500/300'],
    retweetedBy: const [],
    comments: const [],
  ),
  Tweet(
    id: '4',
    user: mockUsers[2],
    content:
        'Just launched a new Flutter project! Check it out on GitHub #FlutterDev',
    timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    likes: 128,
    retweets: 24,
    imageUrls: const ['https://picsum.photos/500/300?random=1'],
    retweetedBy: const [],
    comments: const [],
  ),
  Tweet(
    id: '5',
    user: currentUser,
    content:
        'Working on some exciting new features for our app. Stay tuned for updates!',
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    likes: 89,
    replies: 12,
    retweetedBy: const [],
    comments: const [],
  ),
  Tweet(
    id: '6',
    user: currentUser,
    content: 'Beautiful day for coding outdoors! ☀️ #DeveloperLife',
    timestamp: DateTime.now().subtract(const Duration(days: 2)),
    likes: 215,
    imageUrls: const ['https://picsum.photos/500/300?random=2'],
    retweetedBy: const [],
    comments: const [],
  ),
  Tweet(
    id: '7',
    user: currentUser,
    content:
        'Just gave a talk about Flutter state management at the local meetup. Great turnout!',
    timestamp: DateTime.now().subtract(const Duration(days: 4)),
    likes: 156,
    retweets: 32,
    retweetedBy: const [],
    comments: const [],
  ),
  Tweet(
    id: '8',
    user: currentUser,
    content:
        'New blog post: "10 Flutter Tips for Clean Architecture" - link in bio',
    timestamp: DateTime.now().subtract(const Duration(days: 6)),
    likes: 302,
    replies: 28,
    retweetedBy: const [],
    comments: const [],
  ),
];

final currentUser = User(
  id: '1',
  name: 'محمد اعظم',
  handle: 'azam-izm',
  bio: 'Building awesome apps with Flutter',
  profileImage: 'https://picsum.photos/200',
  bannerImage: 'https://picsum.photos/800/200',
  followers: 786,
  following: 19,
  isVerified: true,
  joinDate: DateTime(2023, 7, 10),
);

// Define the list of users for the MessagesScreen
final List<User> chatUsers = [
  User(
    id: '@elonmusk',
    name: 'Elon Musk',
    handle: 'elonmusk',
    bio: 'CEO of Tesla and SpaceX',
    profileImage: 'https://picsum.photos/201',
    joinDate: DateTime(2007, 3, 21),
    isVerified: true,
  ),
  User(
    id: '@fluttertips',
    name: 'Flutter Tips',
    handle: 'fluttertips',
    bio: 'Daily tips for Flutter developers',
    profileImage: 'https://picsum.photos/203',
    joinDate: DateTime(2019, 5, 10),
    isVerified: false,
  ),
  User(
    id: '@technews',
    name: 'Tech News',
    handle: 'technews',
    bio: 'Latest updates in tech',
    profileImage: 'https://picsum.photos/202',
    joinDate: DateTime(2015, 8, 15),
    isVerified: true,
  ),
  User(
    id: '@azam-izm',
    name: 'محمد اعظم',
    handle: 'azam-izm',
    bio: 'Tech enthusiast',
    profileImage: 'https://picsum.photos/200',
    joinDate: DateTime(2020, 2, 14),
    isVerified: true,
  ),
  User(
    id: '@sarah-harun',
    name: 'Sarah Harun',
    handle: 'sarah-harun',
    bio: 'Designer and artist',
    profileImage: 'https://picsum.photos/205',
    joinDate: DateTime(2017, 11, 25),
    isVerified: false,
  ),
];

// Define the latest messages for each user (for display in the list)
final Map<String, Message> latestMessages = {
  '@elonmusk': Message(
    sender: mockUsers[0],
    text: 'Glad to share! Keep pushing the boundaries of what’s possible.',
    time: DateTime(2025, 3, 7),
    isRead: true,
  ),
  '@fluttertips': Message(
    sender: mockUsers[3],
    text:
        'Simply add a CircularProgressIndicator in the builder\'s connectionState when it\'s waiting for data.',
    time: DateTime(2022, 2, 6),
    isRead: true,
  ),
  '@technews': Message(
    sender: mockUsers[2],
    text:
        'For sure, it’s a big step forward. With dynamic color schemes and more flexible themes, apps will feel more personalized and modern.',
    time: DateTime(2025, 3, 13),
    isRead: true,
  ),
  '@azam-izm': Message(
    sender: currentUser,
    text:
        'Dear myself, one day I’ll make you proud, trust me and have some patience! 😊',
    time: DateTime(2025, 3, 12),
    isRead: true,
  ),
  '@sarah-harun': Message(
    sender: currentUser,
    text: 'From the river to the sea',
    time: DateTime(2023, 10, 7),
    isRead: true,
  ),
};
