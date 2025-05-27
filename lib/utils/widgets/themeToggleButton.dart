import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/router/themeService.dart';

class ThemeToggleButton extends ConsumerWidget {
  final bool showLabel;

  const ThemeToggleButton({super.key, this.showLabel = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeServiceProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => ref.read(themeServiceProvider.notifier).toggleTheme(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(isDarkMode ? 'Light Mode' : 'Dark Mode')
          ],
        ),
      ),
    );
  }
}
