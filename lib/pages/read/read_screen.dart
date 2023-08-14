import 'dart:io';

import 'package:book_app/data/source/shpref/my_shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReadScreen extends StatefulWidget {
  final String path;
  final String name;

  const ReadScreen({super.key, required this.path, required this.name});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  final pref = MySharedPref();
  final controller = PdfViewerController();
  var title = "PDF";
  late final file = File(widget.path);
  var offset = -1.0;

  @override
  void initState() {
    loadPosition();
    controller.addListener(() {
      title = "${controller.pageNumber}/${controller.pageCount}";
      try {
        setState(() {});
      } catch (_) {}
    });
    super.initState();
  }

  Future<void> loadPosition() async {
    offset = await pref.getPosition(widget.path);
    setState(() {});
  }

  @override
  void dispose() {
    pref.setPosition(widget.path, controller.scrollOffset.dy);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(widget.name,style: TextStyle(color: Colors.black, fontSize: 22)),
            Text(title,style: TextStyle(color: Colors.black))
          ],)
        ),
        backgroundColor: Colors.white,
      ),
      body: offset == -1
          ? const Center(child: CircularProgressIndicator())
          : SfPdfViewer.file(
              file,
              initialScrollOffset: Offset(0, offset),
              controller: controller,
            ),
    );
  }
}
