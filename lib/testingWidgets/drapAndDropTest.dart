// import 'package:flutter/material.dart';
// import 'package:wanderverse_app/testingWidgets/dropZoneWidget.dart';
// import 'package:wanderverse_app/testingWidgets/droppedFileWidget.dart';
// import 'package:wanderverse_app/utils/constants.dart';

// class DragAndDropTest extends StatefulWidget {
//   const DragAndDropTest({super.key});

//   @override
//   State<DragAndDropTest> createState() => _DragAndDropTestState();
// }

// class _DragAndDropTestState extends State<DragAndDropTest> {
//   DroppedFile? droppedFile;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Droppedfilewidget(
//               file: droppedFile,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               height: 300,
//               child: Dropzonewidget(
//                 onDroppedFile: (file) => setState(() {
//                   droppedFile = file;
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
