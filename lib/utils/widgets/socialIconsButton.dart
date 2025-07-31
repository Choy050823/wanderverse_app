import 'package:flutter/material.dart';

Widget buildSocialIcon({
  required VoidCallback onPressed,
  required String iconUrl,
  required String label,
}) {
  return Builder(
    builder: (context) {
      final theme = Theme.of(context);

      return SizedBox(
        height: 50,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: theme.colorScheme.onSurface.withOpacity(0.2),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(iconUrl, width: 30, height: 30),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: theme.colorScheme.onSurface)),
            ],
          ),
        ),
      );
    },
  );
}
