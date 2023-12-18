import 'package:flutter/material.dart';
import 'package:google_drive_clone/widgets/storage_container.dart';
import 'package:google_drive_clone/widgets/upload_options.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          StorageContainer(),
          SizedBox(height: MediaQuery.of(context).size.height/20,),
          const Padding(
            padding: EdgeInsets.only(bottom: 18),
            child: UploadOptions(),
          ),
        ],
      ),
    );
  }
}
