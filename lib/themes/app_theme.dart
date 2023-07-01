import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color? primaryColor;
  final Color? placeholderColor;
  final Color? titleColor;
  final Color? progressColor;
  AppTheme({
    this.primaryColor,
    this.placeholderColor,
    this.titleColor,
    this.progressColor,
  });

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? primaryColor,
    Color? placeholderColor,
    Color? titleColor,
    Color? progressColor,
  }) {
    return AppTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      placeholderColor: primaryColor ?? this.placeholderColor,
      titleColor: primaryColor ?? this.titleColor,
      progressColor: progressColor ?? this.progressColor,
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) {
      return this;
    }
    return AppTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      placeholderColor: Color.lerp(placeholderColor, other.placeholderColor, t),
      titleColor: Color.lerp(titleColor, other.titleColor, t),
      progressColor: Color.lerp(progressColor, other.progressColor, t),
    );
  }
}
