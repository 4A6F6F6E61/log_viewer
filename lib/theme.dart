import 'package:fluent_ui/fluent_ui.dart';

final themeData = FluentThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.transparent,
);

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color getFilterColor(String filter, {int alpha = 255}) {
  switch (filter.toLowerCase()) {
    case "error":
      return Colors.errorPrimaryColor.withAlpha(alpha);
    case "warn":
    case "warning":
      return Colors.warningPrimaryColor.withAlpha(alpha);
    case "info":
    case "notice":
      return Colors.successPrimaryColor.withAlpha(alpha);
    case "trace":
      return Colors.errorSecondaryColor.withAlpha(alpha);
  }
  return Colors.magenta.withAlpha(alpha);
}
