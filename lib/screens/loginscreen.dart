import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/controllers/auth_controller.dart';
import 'package:google_drive_clone/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purpleAccent,
              Colors.deepOrangeAccent,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewInsets.top + 52),
                child: const Image(
                  height: 200,
                  width: 200,
                  image: AssetImage('images/filemanager.png'),
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  bottom: 35,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.deepPurple,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    bottom: 25,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Simplify your',
                        style: textStyle(
                          25,
                          const Color(0xff635C9B),
                          FontWeight.w700,
                        ),
                      ),
                      Text(
                        'filing system',
                        style: textStyle(
                          25,
                          const Color(0xff635C9B),
                          FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Keep your files',
                        style: textStyle(
                          20,
                          textColor,
                          FontWeight.w600,
                        ),
                      ),
                      Text(
                        'organized more easily',
                        style: textStyle(
                          20,
                          textColor,
                          FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () => Get.find<AuthController>().login(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.deepPurpleAccent,
                          ),
                          child: Center(
                            child: Text(
                              'Let\'s go',
                              style: textStyle(
                                23,
                                Colors.white,
                                FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
