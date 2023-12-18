import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_drive_clone/models/file_model.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatefulWidget {
  final FileModel file;
  const PdfViewer(this.file, {super.key});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late File pdfFile;
  bool initialized = false;

  initializePDF() async {
    pdfFile = await loadpdfFile(widget.file);
    initialized = true;
    setState(() {});
  }

  loadpdfFile(FileModel file) async {
    final response = await http.get(Uri.parse(file.url));
    final bytes = response.bodyBytes;
    return storeFile(file, bytes);
  }

  storeFile(FileModel file, List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final filename = File('${dir.path}/${file.name}');
    await filename.writeAsBytes(bytes, flush: true);
    return filename;
  }

  @override
  void initState() {
    super.initState();
    initializePDF();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: initialized
            ? PDFView(
                filePath: pdfFile.path,
                fitEachPage: false,
              )
            : Container(),
      ),
    );
  }
}
