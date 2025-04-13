import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_clone_with_bloc/models/message.dart';
import 'package:x_clone_with_bloc/models/mock_data.dart';
import 'package:equatable/equatable.dart';
import 'package:x_clone_with_bloc/models/user.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(const MessageState(messages: [])) {
    on<LoadMessages>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(milliseconds: 500));

      List<dynamic> preloadedMessages = [];

      // Define the specific users with all required fields
      final elonMusk = User(
        id: '@elonmusk',
        name: 'Elon Musk',
        handle: 'elonmusk',
        bio: 'CEO of Tesla and SpaceX',
        profileImage: 'https://picsum.photos/201',
        joinDate: DateTime(2007, 3, 21),
        isVerified: true,
      );

      final flutterTips = User(
        id: '@fluttertips',
        name: 'Flutter Tips',
        handle: 'fluttertips',
        bio: 'Daily tips for Flutter developers',
        profileImage: 'https://picsum.photos/203',
        joinDate: DateTime(2019, 5, 10),
        isVerified: false,
      );

      final techNews = User(
        id: '@technews',
        name: 'Tech News',
        handle: 'technews',
        bio: 'Latest updates in tech',
        profileImage: 'https://picsum.photos/202',
        joinDate: DateTime(2015, 8, 15),
        isVerified: true,
      );

      // Load different conversations for specific users, otherwise use the default
      switch (event.userId) {
        case '@elonmusk':
          preloadedMessages = [
            Message(
              sender: elonMusk,
              text:
                  'Glad to share! Keep pushing the boundaries of what’s possible.',
              time: DateTime(2025, 3, 7),
              isRead: true,
            ),
            {'date': 'Mar 7, 2025'},
            Message(
              sender: currentUser,
              text:
                  'Thanks for the insight, Elon. It\'s inspiring to hear about your vision for the future!',
              time: DateTime(2025, 3, 7),
              isRead: true,
            ),
            Message(
              sender: elonMusk,
              text:
                  'Yes, within the next 10-20 years, it will be as common as flying on a plane.',
              time: DateTime(2025, 3, 7),
              isRead: true,
            ),
            Message(
              sender: currentUser,
              text: 'Do you think space tourism will ever be mainstream?',
              time: DateTime(2025, 3, 7),
              isRead: true,
            ),
            {'date': 'Mar 6, 2025'},
            Message(
              sender: elonMusk,
              text:
                  'We’re aiming for a successful Starship launch to make interplanetary travel possible.',
              time: DateTime(2025, 3, 6),
              isRead: true,
            ),
            Message(
              sender: currentUser,
              text: 'Hey Elon, what’s the next big milestone for SpaceX?',
              time: DateTime(2025, 3, 6),
              isRead: true,
            ),
            {'date': 'Mar 5, 2025'},
          ];
          break;

        case '@fluttertips':
          preloadedMessages = [
            Message(
              sender: flutterTips,
              text:
                  'Simply add a CircularProgressIndicator in the builder\'s connectionState when it\'s waiting for data.',
              time: DateTime(2025, 2, 5),
              isRead: true,
            ),
            Message(
              sender: currentUser,
              text: 'Cool, but how do I show a loading spinner while waiting?',
              time: DateTime(2025, 2, 5),
              isRead: true,
            ),
            {'date': 'Feb 6, 2022'},
            Message(
              sender: flutterTips,
              text:
                  'It listens to a Future and rebuilds the UI once the data is fetched.',
              time: DateTime(2025, 2, 5),
              isRead: true,
            ),
            Message(
              sender: currentUser,
              text: 'Not yet, but it sounds useful. How does it work?',
              time: DateTime(2025, 2, 5),
              isRead: true,
            ),
            Message(
              sender: flutterTips,
              text:
                  'Hey! Have you tried using FutureBuilder for handling async data in Flutter?',
              time: DateTime(2022, 3, 5),
              isRead: true,
            ),
            {'date': 'Feb 5, 2025'},
          ];
          break;

        case '@technews':
          preloadedMessages = [
            Message(
              sender: techNews,
              text:
                  'For sure, it’s a big step forward. With dynamic color schemes and more flexible themes, apps will feel more personalized and modern.',
              time: DateTime(2022, 3, 5),
              isRead: true,
            ),
            Message(
              sender: currentUser,
              text:
                  'Agreed! The theming improvements seem like they’ll make UI design so much easier. What’s your take?',
              time: DateTime(2025, 4, 13),
              isRead: true,
            ),
            {'date': 'Apr 13, 2025'},
            Message(
              sender: techNews,
              text:
                  'Definitely! The expanded privacy options and enhanced performance are game-changers for developers.',
              time: DateTime(2025, 4, 12),
              isRead: true,
            ),
            Message(
              sender: currentUser,
              text:
                  'Did you catch the Android 14 update? The new features are looking pretty solid!',
              time: DateTime(2025, 4, 12),
              isRead: true,
            ),
            {'date': 'Apr 12, 2025'},
          ];
          break;

        case '@azam-izm':
          preloadedMessages = [
            Message(
              sender: currentUser,
              text:
                  'Dear myself, one day I’ll make you proud, trust me and have some patience! 😊',
              time: DateTime(2025, 04, 12),
              isRead: true,
            ),
            {'date': 'Apr 12, 2025'},
          ];
          break;

        default:
          // Default chat structure for all other users
          preloadedMessages = [
            Message(
              sender: User(
                id: event.userId,
                name: 'Other User',
                handle: 'otheruser',
                profileImage: 'https://picsum.photos/206',
                bio: 'Just another user',
                joinDate: DateTime(2023, 7, 10),
                isVerified: false,
              ),
              text: 'From the river to the sea',
              time: DateTime(2022, 3, 6),
              isRead: true,
            ),
            {'date': 'Oct 7, 2023'},
            
          ];
      }

      emit(state.copyWith(
        messages: preloadedMessages,
        isLoading: false,
      ));
    });

    on<SendMessage>((event, emit) {
      final newMessage = Message(
        sender: currentUser,
        text: event.text,
        time: DateTime.now(),
        isRead: true,
      );
      emit(state.copyWith(
        messages: [newMessage, ...state.messages],
      ));
    });
  }
}
