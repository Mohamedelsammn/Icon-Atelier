import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/settings_usecases.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetTheme getTheme;
  final SetTheme setTheme;
  final GetLanguage getLanguage;
  final SetLanguage setLanguage;

  SettingsBloc({
    required this.getTheme,
    required this.setTheme,
    required this.getLanguage,
    required this.setLanguage,
  }) : super(SettingsState(isDarkMode: false, languageCode: 'en')) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleTheme>(_onToggleTheme);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  Future<void> _onLoadSettings(
      LoadSettings event, Emitter<SettingsState> emit) async {
    final themeResult = await getTheme(NoParams());
    final langResult = await getLanguage(NoParams());

    bool isDark = false;
    String lang = 'en';

    themeResult.fold((_) => isDark = false, (res) => isDark = res);
    langResult.fold((_) => lang = 'en', (res) => lang = res);

    emit(state.copyWith(isDarkMode: isDark, languageCode: lang));
  }

  Future<void> _onToggleTheme(
      ToggleTheme event, Emitter<SettingsState> emit) async {
    await setTheme(event.isDark);
    emit(state.copyWith(isDarkMode: event.isDark));
  }

  Future<void> _onChangeLanguage(
      ChangeLanguage event, Emitter<SettingsState> emit) async {
    await setLanguage(event.languageCode);
    emit(state.copyWith(languageCode: event.languageCode));
  }
}
