import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/controllers/navigation_controller.dart';
import 'package:google_drive_clone/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Header extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  Header({super.key});

  Widget tabCell(String text, bool selected, BuildContext context) {
    return selected
        ? Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.deepPurple,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(10, 10),
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(-10, 10),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  text,
                  style: textStyle(
                    23,
                    Colors.white,
                    FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width * 0.45 - 10,
            height: 60,
            child: Center(
              child: Text(
                text,
                style: textStyle(
                  23,
                  textColor,
                  FontWeight.bold,
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
            },
            child: Text(
              'Drive',
              style: textStyle(
                28,
                textColor,
                FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  offset: const Offset(10, 10),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  offset: const Offset(-10, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Obx(
              () => Row(
                children: [
                  InkWell(
                    onTap: () => navController.changeTab('Storage'),
                    child: tabCell('Storage',
                        navController.tab.value == 'Storage', context),
                  ),
                  InkWell(
                    onTap: () => navController.changeTab('Files'),
                    child: tabCell(
                        'Files', navController.tab.value == 'Files', context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
