import 'package:flutter/material.dart';

import 'data.dart';

void main() {
  runApp(const DocumentApp());
}

class DocumentApp extends StatelessWidget {
  const DocumentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: DocumentScreen(
        document: Document(),
      ),
    );
  }
}

class DocumentScreen extends StatelessWidget {
  final Document document;

  const DocumentScreen({
    required this.document,
    Key? key,
  }) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Center(
  //           child:  Text('Title goes here')
  //       ),
  //     ),
  //     body: const Column(
  //       children: [
  //         Center(
  //           child: Text('Body goes here'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   var metadataRecord = document.getMetaData();
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       centerTitle: true,
  //       title: Text(metadataRecord.$1),
  //     ),
  //     body: Column(
  //       children: [
  //         Center(
  //           child: Text(
  //             'Last modified ${metadataRecord.modified}',
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   var (title, :modified) = document.getMetadata();
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       centerTitle: true,
  //       title: Text(title),
  //     ),
  //     body: Column(
  //       children: [
  //         Center(
  //           child: Text(
  //             'Last modified $modified',
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   var (title, :modified) = document.getMetadata();
  //   var blocks = document.getBlocks();
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(title),
  //     ),
  //     body: Column(
  //       children: [
  //         Text('Last modified: $modified'),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: blocks.length,
  //             itemBuilder: (context, index) {
  //               return BlockWidget(block: blocks[index]);
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var (title, :modified) = document.getMetadata();
    var formattedModifiedDate = formatDate(modified); // New
    var blocks = document.getBlocks();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Text('Last modified: $formattedModifiedDate'), // New
          Expanded(
            child: ListView.builder(
              itemCount: blocks.length,
              itemBuilder: (context, index) =>
                  BlockWidget(block: blocks[index]),
            ),
          ),
        ],
      ),
    );
  }
}

// class BlockWidget extends StatelessWidget {
//   final Block block;
//
//   const BlockWidget({
//     required this.block,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     TextStyle? textStyle;
//     textStyle = switch (block.type) {
//       'h1' => Theme.of(context).textTheme.displayMedium,
//       'p' || 'checkbox' => Theme.of(context).textTheme.bodyMedium,
//       _ => Theme.of(context).textTheme.bodySmall
//     };
//
//     return Container(
//       margin: const EdgeInsets.all(8),
//       child: Text(
//         block.text,
//         style: textStyle,
//       ),
//     );
//   }
// }

class BlockWidget extends StatelessWidget {
  final Block block;

  const BlockWidget({
    required this.block,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: switch (block) {
        HeaderBlock(:var text) => Text(
          text,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        ParagraphBlock(:var text) => Text(text),
        CheckboxBlock(:var text, :var isChecked) => Row(
          children: [
            Checkbox(value: isChecked, onChanged: (_) {}),
            Text(text),
          ],
        ),
      },
    );
  }
}