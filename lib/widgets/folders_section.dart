import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/controllers/files_controller.dart';
import 'package:google_drive_clone/controllers/files_screen_controller.dart';
import 'package:google_drive_clone/screens/display_files_screen.dart';
import 'package:google_drive_clone/utils.dart';

class FoldersSection extends StatelessWidget {
  const FoldersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<FilesScreenController>(
        builder: (FilesScreenController foldersController) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: foldersController.foldersList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Get.to(
                () => DisplayFilesScreen(
                    foldersController.foldersList[index].name, 'folder'),
                binding: FilesBinding(
                    'Folders',
                    foldersController.foldersList[index].name,
                    foldersController.foldersList[index].name)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.00001),
                      offset: const Offset(10, 10),
                      blurRadius: 5),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/folder.png',
                    width: 82,
                    height: 82,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    foldersController.foldersList[index].name,
                    style: textStyle(18, textColor, FontWeight.bold),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: userCollection
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('files')
                          .where('folder',
                              isEqualTo:
                                  foldersController.foldersList[index].name)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        return Text(
                          '${snapshot.data!.docs.length} item',
                          style: textStyle(
                              14, Colors.grey.shade400, FontWeight.bold),
                        );
                      }),
                ],
              ),
            ),
          );
        },
      );
        });
  }
}
