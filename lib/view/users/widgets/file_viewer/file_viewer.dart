import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:path_provider/path_provider.dart';

class FileViewerPage extends StatefulWidget {
  final String pdfUrl;
  final String pdfName;

  FileViewerPage({required this.pdfUrl, required this.pdfName});

  @override
  _FileViewerPageState createState() => _FileViewerPageState();
}

class _FileViewerPageState extends State<FileViewerPage> {
  late Future<String> localFilePath;

  @override
  void initState() {
    super.initState();
    localFilePath = _downloadAndSaveFile(widget.pdfUrl);
  }

  Future<String> _downloadAndSaveFile(String url) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = url.split('/').last.split('?').first;
    final filePath = '${directory.path}/$fileName';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Exception('Failed to download file');
    }
  }

  bool isPDF(String path) {
    return path.toLowerCase().endsWith('.pdf');
  }

  bool isImage(String path) {
    return path.toLowerCase().endsWith('.jpg') ||
        path.toLowerCase().endsWith('.jpeg') ||
        path.toLowerCase().endsWith('.png') ||
        path.toLowerCase().endsWith('.gif');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          widget.pdfName,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: FutureBuilder<String>(
        future: localFilePath,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final path = snapshot.data!;
            if (isPDF(path)) {
              return PDFView(filePath: path);
            } else if (isImage(path)) {
              return Center(child: Image.file(File(path)));
            } else {
              return Center(child: Text("Unsupported file type"));
            }
          } else {
            return Center(child: Text("No file found"));
          }
        },
      ),
    );
  }
}
