import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFSectionScreen extends StatelessWidget {
  final String urlPdf;

  const PDFSectionScreen({
    super.key,
    required this.urlPdf,
  });

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: PDFView(
        filePath: urlPdf,
      ),
    );
  }
}
