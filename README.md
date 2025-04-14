# 📱 X Clone with bloC

A Flutter-based social media application that mimics the core functionalities of X (formerly Twitter), built using the BLoC (Business Logic Component) pattern for state management. This project includes features like a home timeline, composing tweets, user profiles, search, notifications, following/unfollowing users, a messaging system with preloaded conversations, and a tweet detail screen for viewing individual tweets.

## Features

- **Home Timeline**: View a list of tweets using `TweetBloc`.
- **Compose Tweets**: Post new tweets with `TweetBloc`.
- **Tweet Detail**: View details of a specific tweet, including comments, likes, and retweets (uses `TweetBloc`).
- **User Profiles**: View user profiles with details like bio, followers, and join date.
- **Search**: Search functionality for users or tweets.
- **Notifications**: View notifications (stubbed for now).
- **Follow/Unfollow**: Follow or unfollow users using `FollowBloc`.
- **Messages**: A messaging system with preloaded conversations for specific users (`@elonmusk`, `@fluttertips`, `@technews`, `@azam-izm`) and a default conversation for others.
  - Custom conversations for `@elonmusk`, `@fluttertips`, and `@technews`.
  - A single sent message for `@azam-izm`.
  - Default chat for other users with date chips and a natural conversation flow.
- **Theme Switching**: Toggle between light and dark themes using `ThemeBloc`.
- **Responsive UI**: Designed to work on both iOS and Android.

## Project Structure

The project follows a clean architecture with the BLoC pattern for state management. Below is the structure of the `lib/` directory:

## 📂 Project Structure
```
lib/
├── blocs/                  # All state managers using BLoC pattern
│   ├── follow/             # Follow/unfollow functionality (BLoC)
│   │   ├── follow_bloc.dart
│   │   ├── follow_event.dart
│   │   └── follow_state.dart
│   │
│   ├── message/            # Message interactions (BLoC for messaging)
│   │   ├── message_bloc.dart
│   │   ├── message_event.dart
│   │   └── message_state.dart
│   │
│   ├── theme/              # Theme switcher (BLoC for theme management)
│   │   ├── theme_bloc.dart
│   │   ├── theme_event.dart
│   │   └── theme_state.dart
│   │
│   └── tweet/              # Tweet interactions (BLoC for tweets)
│       ├── tweet_bloc.dart
│       ├── tweet_event.dart
│       └── tweet_state.dart
│
├── models/                 # Data models for the app
│   ├── comment.dart        # Comment model (for tweet comments)
│   ├── message.dart        # Message model for chat functionality
│   ├── mock_data.dart      # Mock data for users, tweets, and messages
│   ├── tweet.dart          # Tweet model
│   └── user.dart           # User model with fields like id, name, handle, bio, etc.
│
├── screens/                 # UI screens of the app
│   ├── compose_tweet_screen.dart    # Screen to compose new tweets (uses TweetBloc)
│   ├── home_screen.dart             # Home timeline screen (uses TweetBloc)
│   ├── main_screen.dart             # Main screen with bottom navigation (uses ThemeBloc)
│   ├── messages_screen.dart         # Messages screen with chat list and chat detail (uses MessageBloc)
│   ├── notifications_screen.dart    # Notifications screen
│   ├── profile_screen.dart          # User profile screen
│   └── search_screen.dart           # Search screen
│   └── tweet_detail_screen.dart     # Screen to view details of a specific tweet (uses TweetBloc)
├── widgets/                # Reusable widgets
│   └── tweet_widget.dart            # Widget for displaying a tweet (uses TweetBloc)
│
└── main.dart               # Entry point of the app with BLoC provider setup
```

## Dependencies
The project uses the following key packages:
`flutter_bloc`: For state management using the BLoC pattern.

`equatable`: To simplify equality comparisons for state objects.

`timeago`: To format timestamps (e.g., "2 days ago") in the UI.

You can find the full list of dependencies in the `pubspec.yaml` file.


