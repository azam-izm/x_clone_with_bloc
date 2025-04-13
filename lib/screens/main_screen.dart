// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:x_clone_with_bloc/screens/compose_tweet_screen.dart';
import 'package:x_clone_with_bloc/screens/home_screen.dart';
import 'package:x_clone_with_bloc/screens/messages_screen.dart';
import 'package:x_clone_with_bloc/screens/notifications_screen.dart';
import 'package:x_clone_with_bloc/screens/search_screen.dart';

/*
The MainScreen serves as the primary navigation hub for an X (Twitter)
clone, featuring a bottom navigation bar with four tabs, Home, Search, Notifications, and 
Messages, each corresponding to a dedicated screen (HomeScreen, SearchScreen, 
NotificationsScreen, MessagesScreen).
*/

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = const [
      HomeScreen(),
      SearchScreen(),
      NotificationsScreen(),
      MessagesScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () => _navigateToComposeTweet(context),
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: ''),
        ],
      ),
    );
  }

  void _navigateToComposeTweet(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ComposeTweetScreen()),
    );
  }
}
