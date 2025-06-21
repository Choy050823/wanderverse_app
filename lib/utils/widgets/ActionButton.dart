import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  const ActionButton({required this.icon, required this.label, super.key});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TextButton.icon(
      onPressed: () {},
      icon: Icon(
        widget.icon,
        size: 18,
        color: colorScheme.onSurfaceVariant,
      ),
      label: Text(
        widget.label,
        style: textTheme.labelMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
    );
  }
}
