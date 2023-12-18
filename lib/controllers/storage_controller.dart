import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/utils.dart';

class StorageController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxInt size = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getStorage();
  }

  getStorage() {
    size.bindStream(userCollection
        .doc(uid)
        .collection('files')
        .snapshots()
        .map((QuerySnapshot query) {
      int size = 0;
      for (var element in query.docs) {
        size = size + extractSize(element);
      }
      return size;
    }));
  }

  int extractSize(QueryDocumentSnapshot<Object?> element) {
    return element['size'];
  }
}
