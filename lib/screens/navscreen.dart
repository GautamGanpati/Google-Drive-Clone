import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/controllers/navigation_controller.dart';
import 'package:google_drive_clone/screens/files_screen.dart';
import 'package:google_drive_clone/screens/storagescreen.dart';

import '../widgets/header.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(25),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        body: Column(
          children: [
            Header(),
            Obx(
              () => Get.find<NavigationController>().tab.value == 'Storage'
                  ? const StorageScreen()
                  : FilesScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
