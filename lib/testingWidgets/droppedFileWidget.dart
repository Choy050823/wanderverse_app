// import 'package:flutter/material.dart';
// import 'package:wanderverse_app/utils/constants.dart';

// class Droppedfilewidget extends StatelessWidget {
//   final DroppedFile? file;
//   const Droppedfilewidget({super.key, this.file});

//   @override
//   Widget build(BuildContext context) => Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           buildImage(),
//           if (file != null) buildFileDetail(file!),
//         ],
//       );

//   Widget buildImage() {
//     if (file == null) return buildEmptyFile('No File');
//     return Image.network(
//       file!.fileData.toString(),
//       width: 120,
//       height: 120,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) =>
//           buildEmptyFile('No Preview'),
//     );
//   }

//   Widget buildEmptyFile(String text) => Container(
//         width: 120,
//         height: 120,
//         color: Colors.blue.shade300,
//         child: Center(
//           child: Text(text),
//         ),
//       );

//   Widget buildFileDetail(DroppedFile file) {
//     const style = TextStyle(fontSize: 20);

//     return Container(
//       margin: const EdgeInsets.only(left: 24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             file.name,
//             style: style.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Text(
//             file.mime,
//             style: style,
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Text(
//             file.size,
//             style: style,
//           )
//         ],
//       ),
//     );
//   }
// }
