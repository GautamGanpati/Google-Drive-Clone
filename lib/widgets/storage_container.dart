import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/controllers/storage_controller.dart';
import 'package:google_drive_clone/utils.dart';

class StorageContainer extends StatelessWidget {
  final StorageController controller = Get.put(StorageController());

  StorageContainer({super.key});

  getSize(int size) {
    if (size < 1000) {
      return "$size KB";
    } else if (size < 1000000) {
      int sizeMB = (size * 0.001).round();
      return '$sizeMB MB';
    } else {
      int sizeGB = (size * 0.000001).round();
      return '$sizeGB GB';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.001),
            offset: const Offset(10, 10),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.001),
            offset: const Offset(-10, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 25,
          bottom: 25,
        ),
        child: Obx(
          () => Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ((controller.size.value / 1000000) * 100)
                              .round()
                              .toString(),
                          style: textStyle(
                            48,
                            Colors.deepOrange,
                            FontWeight.bold,
                          ),
                        ),
                        Text(
                          '%',
                          style: textStyle(
                            18,
                            Colors.deepOrange,
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Used',
                      style: textStyle(
                        22,
                        textColor.withOpacity(0.7),
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        children: [
                          Text(
                            'Used',
                            style: textStyle(
                              18,
                              textColor.withOpacity(0.7),
                              FontWeight.w600,
                            ),
                          ),
                          Text(
                            getSize(controller.size.value),
                            style: textStyle(
                              20,
                              const Color(0xff635C9B),
                              FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.lightGreen,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        children: [
                          Text(
                            'Free',
                            style: textStyle(
                              18,
                              textColor.withOpacity(0.7),
                              FontWeight.w600,
                            ),
                          ),
                          Text(
                            '1 GB',
                            style: textStyle(
                              20,
                              const Color(0xff635C9B),
                              FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
