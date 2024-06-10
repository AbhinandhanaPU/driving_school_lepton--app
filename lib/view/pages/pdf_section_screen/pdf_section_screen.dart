import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFSectionScreen extends StatelessWidget {
  final String urlPdf;
  const PDFSectionScreen({
    super.key,
    required this.urlPdf,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.network(urlPdf),
    );
  }
}
