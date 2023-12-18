import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/controllers/files_screen_controller.dart';
import 'package:google_drive_clone/firebase.dart';
import 'package:google_drive_clone/screens/navscreen.dart';
import 'package:google_drive_clone/utils.dart';
import 'package:google_drive_clone/widgets/folders_section.dart';
import 'package:google_drive_clone/widgets/recent_files.dart';

class FilesScreen extends StatelessWidget {
  FilesScreen({super.key});

  final TextEditingController folderController = TextEditingController();
  final FilesScreenController filesScreenController =
      Get.put(FilesScreenController());

  openAddFolderDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.only(right: 10, bottom: 10),
          title: Text(
            'New Folder',
            style: textStyle(17, Colors.black, FontWeight.w600),
          ),
          content: TextFormField(
            controller: folderController,
            autofocus: true,
            style: textStyle(17, Colors.black, FontWeight.w600),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[250],
              hintText: 'Untitled Folder',
              hintStyle: textStyle(16, Colors.grey, FontWeight.w500),
            ),
          ),
          actions: [
            InkWell(
              onTap: () => Get.back(),
              child: Text(
                'Cancel',
                style: textStyle(16, textColor, FontWeight.w500),
              ),
            ),
            InkWell(
              onTap: () {
                userCollection
                    .doc(
                      FirebaseAuth.instance.currentUser!.uid,
                    )
                    .collection('folders')
                    .add({
                  'name': folderController.text,
                  'time': DateTime.now(),
                });
                Get.offAll(const NavScreen());
              },
              child: Text(
                'Create',
                style: textStyle(16, textColor, FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30,
        ),
        child: Stack(
          children: [
            const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecentFiles(),
                  FoldersSection(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () => openAddFolderDialog(context),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        EvaIcons.folderAdd,
                                        color: Colors.deepOrangeAccent,
                                        size: 32,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Folder',
                                        style: textStyle(
                                            20, Colors.black, FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    FirebaseService().uploadFile('');
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Upload',
                                        style: textStyle(
                                            20, Colors.black, FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        EvaIcons.upload,
                                        color: Colors.blue,
                                        size: 32,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
