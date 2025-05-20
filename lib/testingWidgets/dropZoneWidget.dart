// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dropzone/flutter_dropzone.dart';
// import 'package:wanderverse_app/utils/constants.dart';

// class Dropzonewidget extends StatefulWidget {
//   final ValueChanged<DroppedFile> onDroppedFile;
//   const Dropzonewidget({super.key, required this.onDroppedFile});

//   @override
//   State<Dropzonewidget> createState() => _DropzonewidgetState();
// }

// class _DropzonewidgetState extends State<Dropzonewidget> {
//   late DropzoneViewController controller;
//   bool isHighlighted = false;

//   @override
//   Widget build(BuildContext context) {
//     final colorBackground = isHighlighted ? Colors.blue : Colors.green;
//     final colorButton =
//         isHighlighted ? Colors.blue.shade300 : Colors.green.shade300;

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         color: colorBackground,
//         padding: const EdgeInsets.all(10),
//         child: DottedBorder(
//           borderType: BorderType.RRect,
//           color: Colors.white,
//           strokeWidth: 3,
//           padding: EdgeInsets.zero,
//           dashPattern: const [8, 4],
//           radius: const Radius.circular(10),
//           child: Stack(
//             children: [
//               DropzoneView(
//                 onCreated: (controller) => this.controller = controller,
//                 onHover: () => setState(() {
//                   isHighlighted = true;
//                 }),
//                 onLeave: () => setState(() {
//                   isHighlighted = false;
//                 }),
//                 onDropFile: acceptFile,
//                 onDropFiles: (List<DropzoneFileInterface>? files) {
//                   if (files == null) return;
//                   for (DropzoneFileInterface file in files) {
//                     print('accept file from drop');
//                     acceptFile(file);
//                   }
//                 },
//               ),
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.cloud_upload,
//                       size: 80,
//                       color: Colors.white,
//                     ),
//                     const Text(
//                       'Drop Files here',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(horizontal: 64),
//                           shape: const RoundedRectangleBorder(),
//                           backgroundColor: colorButton),
//                       onPressed: () async {
//                         final events = await controller.pickFiles();
//                         if (events.isEmpty) return;

//                         for (var file in events) {
//                           print('accept file');
//                           acceptFile(file);
//                         }
//                       },
//                       icon: const Icon(
//                         Icons.search,
//                         size: 32,
//                       ),
//                       label: const Text(
//                         'Choose Files',
//                         style: TextStyle(color: Colors.white, fontSize: 24),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> acceptFile(dynamic event) async {
//     final name = await controller.getFilename(event);
//     final mime = await controller.getFileMIME(event);
//     final bytes = await controller.getFileSize(event);
//     final url = await controller.createFileUrl(event);
//     final droppedFile =
//         DroppedFile(url: url, name: name, mime: mime, bytes: bytes);

//     print('Name ${droppedFile.name}');

//     widget.onDroppedFile(droppedFile);
//     setState(() {
//       isHighlighted = false;
//     });
//   }
// }
