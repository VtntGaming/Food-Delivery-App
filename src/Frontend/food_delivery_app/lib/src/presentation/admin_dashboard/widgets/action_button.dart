import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const ActionButton({Key? key, required this.label, required this.onPressed, required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(label, style: theme.textStyles.buttonPrimary),
      ),
    );
  }
}
