import 'package:fluent_ui/fluent_ui.dart';

class FilterToggleButton extends StatelessWidget {
  const FilterToggleButton({
    super.key,
    required this.checked,
    required this.checkedColor,
    required this.onChanged,
    required this.label,
  });

  final bool checked;
  final Color checkedColor;
  final void Function(bool)? onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ToggleButton(
      checked: checked,
      onChanged: onChanged,
      style: ToggleButtonThemeData(
        checkedButtonStyle: ButtonStyle(
          backgroundColor: WidgetStateMapper({WidgetState.any: checkedColor}),
        ),
        uncheckedButtonStyle: ButtonStyle(
          foregroundColor: WidgetStateMapper({WidgetState.any: Colors.white.withAlpha(100)}),
        ),
      ),

      child: Text(label),
    );
  }
}
