import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_clone_with_bloc/bloc/message/message_bloc.dart';
import 'package:x_clone_with_bloc/bloc/theme/theme_bloc.dart';
import 'package:x_clone_with_bloc/screens/main_screen.dart';
import 'bloc/tweet/tweet_bloc.dart';

void main() {
  runApp(const XCloneApp());
}

class XCloneApp extends StatelessWidget {
  const XCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<TweetBloc>(
          create: (context) => TweetBloc()..add(LoadTweets()),
        ),
        BlocProvider<MessageBloc>(
          create: (context) => MessageBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          print('toggle day & night mode');
          return MaterialApp(
            title: 'X Clone',
            debugShowCheckedModeBanner: false,
            theme: state.isDarkMode ? _buildDarkTheme() : _buildLightTheme(),
            home: const MainScreen(),
          );
        },
      ),
    );
  }

  ThemeData _buildLightTheme() => ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      );

  ThemeData _buildDarkTheme() => ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          elevation: 1,
        ),
      );
}
