import 'package:flutter/material.dart';

Widget buildTextField(
    {required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator}) {
  return Builder(builder: (context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      // Use theme colors for text
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: labelText,
        // Use theme colors for label
        labelStyle:
            TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7)),
        filled: true,
        // Use theme colors for background
        fillColor: theme.colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: theme.colorScheme.primary.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: theme.colorScheme.onSurface.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        suffixIcon: suffixIcon != null
            ? IconTheme(
                data: IconThemeData(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                child: suffixIcon,
              )
            : null,
      ),
      validator: validator,
    );
  });
}
