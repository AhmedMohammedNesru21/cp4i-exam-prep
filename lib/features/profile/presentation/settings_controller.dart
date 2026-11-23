import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/providers.dart';

class AppSettings {
  const AppSettings({required this.themeMode, required this.onboardingComplete, required this.displayName});
  final ThemeMode themeMode;
  final bool onboardingComplete;
  final String displayName;

  AppSettings copyWith({ThemeMode? themeMode, bool? onboardingComplete, String? displayName}) => AppSettings(
        themeMode: themeMode ?? this.themeMode,
        onboardingComplete: onboardingComplete ?? this.onboardingComplete,
        displayName: displayName ?? this.displayName,
      );
}

final settingsProvider = NotifierProvider<SettingsController, AppSettings>(SettingsController.new);

class SettingsController extends Notifier<AppSettings> {
  static const _theme = 'theme_mode';
  static const _onboarding = 'onboarding_complete';
  static const _name = 'display_name';

  @override
  AppSettings build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return AppSettings(
      themeMode: ThemeMode.values.byName(prefs.getString(_theme) ?? ThemeMode.system.name),
      onboardingComplete: prefs.getBool(_onboarding) ?? false,
      displayName: prefs.getString(_name) ?? '',
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await ref.read(sharedPreferencesProvider).setString(_theme, mode.name);
  }

  Future<void> completeOnboarding({String? displayName}) async {
    state = state.copyWith(onboardingComplete: true, displayName: displayName);
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_onboarding, true);
    if (displayName != null) await prefs.setString(_name, displayName);
  }

  Future<void> setDisplayName(String name) async {
    state = state.copyWith(displayName: name);
    await ref.read(sharedPreferencesProvider).setString(_name, name);
  }
}
