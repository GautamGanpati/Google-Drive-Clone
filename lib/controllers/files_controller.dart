import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/models/file_model.dart';
import 'package:google_drive_clone/utils.dart';

class FilesController extends GetxController {
  final String type;
  final String foldername;
  final String fileType;

  FilesController(this.type, this.foldername, this.fileType);

  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxList<FileModel> files = <FileModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (type == 'files') {
      files.bindStream(userCollection
          .doc(uid)
          .collection('files')
          .where('fileType', isEqualTo: fileType)
          .snapshots()
          .map((QuerySnapshot query) {
        List<FileModel> tempFiles = [];
        List<QueryDocumentSnapshot<Object?>> docslist = query.docs;
        for (var doc in docslist) {
          tempFiles.add(FileModel.fromDocumentSnapshot(doc));
        }
        return tempFiles;
      }));
    } else {
      files.bindStream(
        userCollection
            .doc(uid)
            .collection('files')
            .where('folder', isEqualTo: foldername)
            .snapshots()
            .map((QuerySnapshot query) {
          List<FileModel> tempFiles = [];
          for (var element in query.docs) {
            tempFiles.add(FileModel.fromDocumentSnapshot(element));
          }
          return tempFiles;
        }),
      );
    }
  }
}

class FilesBinding implements Bindings {
  final String type;
  final String foldername;
  final String fileType;

  FilesBinding(this.type, this.foldername, this.fileType);

  @override
  void dependencies() {
    Get.lazyPut<FilesController>(
      () => FilesController(type, foldername, fileType),
    );
  }
}
