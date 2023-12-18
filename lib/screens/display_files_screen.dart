// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/controllers/files_controller.dart';
import 'package:google_drive_clone/firebase.dart';
import 'package:google_drive_clone/screens/view_file_screen.dart';
import 'package:google_drive_clone/utils.dart';

class DisplayFilesScreen extends StatelessWidget {
  DisplayFilesScreen(this.title, this.type, {super.key});

  final String title;
  final String type;

  final FilesController filesController = Get.find<FilesController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: textColor,
              ),
            ),
            title: Text(
              title,
              style: textStyle(18, textColor, FontWeight.bold),
            ),
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () => type == 'folder'
              ? FirebaseService().uploadFile(title)
              : FirebaseService().uploadFile(''),
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
        body: Obx(
          () => GridView.builder(
              itemCount: filesController.files.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.25),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Get.to(
                      () => ViewFileScreen(filesController.files[index])),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 10, top: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        children: [
                          filesController.files[index].fileType == 'image'
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image(
                                    image: NetworkImage(
                                        filesController.files[index].url),
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  height: 75,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 0.2),
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Center(
                                    child: Image(
                                      image: AssetImage(
                                          'images/${filesController.files[index].fileExtension}.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2, left: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    filesController.files[index].name,
                                    style: textStyle(
                                        14, textColor, FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.black,
                                    size: 20,
                                  ),
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
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  filesController
                                                      .files[index].name,
                                                  style: textStyle(
                                                      16,
                                                      Colors.black,
                                                      FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                                color: Colors.grey, height: 3),
                                            ListTile(
                                              onTap: () {
                                                FirebaseService().downloadfile(
                                                    filesController
                                                        .files[index]);
                                                Get.back();
                                              },
                                              leading: const Icon(
                                                  Icons.file_download,
                                                  color: Colors.green),
                                              dense: true,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 0,
                                                      left: 16,
                                                      top: 12),
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: 0,
                                                      vertical: -4),
                                              title: Text(
                                                'Download',
                                                style: textStyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.w500),
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                FirebaseService().deleteFile(
                                                    filesController
                                                        .files[index]);
                                                Get.back();
                                              },
                                              leading: const Icon(Icons.delete,
                                                  color: Colors.redAccent),
                                              dense: true,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 12,
                                                      left: 16,
                                                      top: 8),
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: 0,
                                                      vertical: -4),
                                              title: Text(
                                                'Remove',
                                                style: textStyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
