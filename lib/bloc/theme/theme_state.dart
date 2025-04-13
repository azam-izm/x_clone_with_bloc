part of 'theme_bloc.dart';

class ThemeState {
  final bool isDarkMode;
  ThemeState({required this.isDarkMode});

  ThemeState copyWith({bool? isDarkMode}) {
    return ThemeState(isDarkMode: isDarkMode ?? this.isDarkMode);
  }
}
