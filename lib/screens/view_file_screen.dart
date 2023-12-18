import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/firebase.dart';
import 'package:google_drive_clone/models/file_model.dart';
import 'package:google_drive_clone/utils.dart';
import 'package:google_drive_clone/widgets/audio_player_widget.dart';
import 'package:google_drive_clone/widgets/pdf_viewer.dart';
import 'package:google_drive_clone/widgets/video_player_widget.dart';

class ViewFileScreen extends StatelessWidget {
  final FileModel file;

  const ViewFileScreen(this.file, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              file.name,
              style: textStyle(18, Colors.white, FontWeight.w600),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                file.name,
                                style: textStyle(
                                    16, Colors.black, FontWeight.w500),
                              ),
                            ),
                          ),
                          const Divider(color: Colors.grey, height: 3),
                          ListTile(
                            onTap: () {
                              FirebaseService().downloadfile(file);
                              Get.back();
                            },
                            leading: const Icon(Icons.file_download,
                                color: Colors.green),
                            dense: true,
                            contentPadding: const EdgeInsets.only(
                                bottom: 0, left: 16, top: 12),
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Text(
                              'Download',
                              style:
                                  textStyle(16, Colors.black, FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              FirebaseService().deleteFile(file);
                              Get.back();
                            },
                            leading: const Icon(Icons.delete,
                                color: Colors.redAccent),
                            dense: true,
                            contentPadding: const EdgeInsets.only(
                                bottom: 12, left: 16, top: 8),
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Text(
                              'Remove',
                              style:
                                  textStyle(16, Colors.black, FontWeight.w500),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
        body: file.fileType == 'image'
            ? showImage(file.url)
            : file.fileType == 'application'
                ? showFile(file, context)
                : file.fileType == 'video'
                    ? VideoPlayerWidget(file.url)
                    : file.fileType == 'audio'
                        ? AudioPlayerWidget(file.url)
                        : showError(),
      ),
    );
  }
}

showError() {}

showImage(String url) {
  return Center(
    child: Image(
      image: NetworkImage(url),
    ),
  );
}

showFile(FileModel file, BuildContext context) {
  if (file.fileExtension == 'pdf') {
    return PdfViewer(file);
  } else {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            'This file cannot be opened',
            style: textStyle(18, Colors.white, FontWeight.w700),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 36,
            child: TextButton(
              onPressed: () {
                FirebaseService().downloadfile(file);
              },
              style: TextButton.styleFrom(backgroundColor: Colors.purple),
              child: Center(
                child: Text(
                  'Download',
                  style: textStyle(17, Colors.white, FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
