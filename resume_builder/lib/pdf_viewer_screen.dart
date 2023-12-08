import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatefulWidget {
  final File file;

  const PDFViewerScreen({super.key, required this.file});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFFDFEDFA),
          // Color of the status bar
          statusBarIconBrightness: Brightness.dark,
          // Brightness of system icons (e.g., network, battery)
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFEDFA),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "PDF",
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Color(0xFFDFEDFA),
      ),
      body: SfPdfViewer.file(widget.file),
    );
  }
}
