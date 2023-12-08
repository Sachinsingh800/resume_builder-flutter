import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWid;
import 'package:printing/printing.dart';

class PDFFormat extends StatelessWidget {
  final Uint8List image;
  final String name;
  const PDFFormat({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDFView"),
      ),
      body: Center(
        child: PdfPreview(
          build: (format) => _createPdf(
              format, context
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _createPdf(
      PdfPageFormat format, BuildContext cont
      ) async {
    final pdf = pdfWid.Document(
      version: PdfVersion.pdf_1_4,
      compress: true,
    );

    pdf.addPage(
      pdfWid.Page(
        pageFormat:  PdfPageFormat(595, 842, marginAll: 8),
        //pageFormat: format,
        build: (context) {
          return
          pdfWid.Center(
            child:
            pdfWid.Container(
              width: double.infinity,
              height: 842,
              child: pdfWid.FittedBox(
                fit: pdfWid.BoxFit.fill,
                child: pdfWid.Image(pdfWid.MemoryImage(image), fit: pdfWid.BoxFit.fill),
              ),
            )
          );
        },
      ),
    );
    return pdf.save();
  }
}
