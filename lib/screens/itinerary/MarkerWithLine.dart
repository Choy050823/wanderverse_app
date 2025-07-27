import 'package:flutter/material.dart';
import 'package:wanderverse_app/utils/appTheme.dart';

class MarkerWithLine extends StatelessWidget {
  final int index;
  final bool isLast;

  const MarkerWithLine({super.key, required this.index, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: AppTheme.secondaryTeal,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              index.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Vertical line for connection (not shown for last item)
        if (!isLast)
          Container(
            width: 2,
            height: 120, // Adjust height to fit your content
            margin: const EdgeInsets.only(top: 8),
            color: AppTheme.lightGrey,
          ),
      ],
    );
  }
}
