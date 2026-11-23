import 'package:material_ui/material_ui.dart';

/// Navy and blue professional theme (IBM-inspired accents, no IBM branding).
class AppColors {
  AppColors._();
  static const navy = Color(0xFF0B1A33);
  static const navySurface = Color(0xFF12264A);
  static const blue = Color(0xFF0F62FE);
  static const blueLight = Color(0xFF78A9FF);
  static const correct = Color(0xFF24A148);
  static const incorrect = Color(0xFFDA1E28);
  static const warning = Color(0xFFF1C21B);
  static const cardLight = Color(0xFFFFFFFF);
  static const backgroundLight = Color(0xFFF2F4F8);
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      primary: AppColors.blue,
      surface: AppColors.cardLight,
      error: AppColors.incorrect,
    );
    return _base(scheme).copyWith(
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      brightness: Brightness.dark,
      primary: AppColors.blueLight,
      surface: AppColors.navySurface,
      error: const Color(0xFFFF8389),
    );
    return _base(scheme).copyWith(
      scaffoldBackgroundColor: AppColors.navy,
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.navy, foregroundColor: Colors.white),
    );
  }

  static ThemeData _base(ColorScheme scheme) => ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
        visualDensity: VisualDensity.standard,
        cardTheme: CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(64, 52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(64, 52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
}
