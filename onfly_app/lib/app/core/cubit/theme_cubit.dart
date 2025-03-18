import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/core/cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(AppThemeMode.light));

  void toggleTheme() {
    if (state.themeMode == AppThemeMode.light) {
      emit(const ThemeState(AppThemeMode.dark));
    } else {
      emit(const ThemeState(AppThemeMode.light));
    }
  }
}
