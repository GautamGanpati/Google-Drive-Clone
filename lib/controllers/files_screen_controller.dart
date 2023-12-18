import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/models/file_model.dart';
import 'package:google_drive_clone/models/folder_model.dart';
import 'package:google_drive_clone/utils.dart';

class FilesScreenController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxList<FolderModel> foldersList = <FolderModel>[].obs;
  RxList<FileModel> recentfilesList = <FileModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    recentfilesList.bindStream(
      userCollection
          .doc(uid)
          .collection('files')
          .orderBy('dateUploaded', descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        List<FileModel> files = [];
        for (var element in query.docs) {
          files.add(FileModel.fromDocumentSnapshot(element));
        }
        return files;
      }),
    );
    foldersList.bindStream(
      userCollection
          .doc(uid)
          .collection('folders')
          .orderBy('time', descending: true)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<FolderModel> folders = [];
          for (var element in query.docs) {
              FolderModel folder = FolderModel.fromDocumentSnapshot(element);
              folders.add(folder);
            }
          return folders;
        },
      ),
    );
  }
}
