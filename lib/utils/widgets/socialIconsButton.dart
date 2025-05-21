import 'package:flutter/material.dart';

Widget buildSocialIcon({
  required VoidCallback onPressed,
  required String iconUrl,
  required String label,
}) {
  return Expanded(
      child: SizedBox(
    height: 50,
    child: OutlinedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   icon,
            //   style:
            //       TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            // ),
            Image.network(
              iconUrl,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ],
        )),
  ));
}
