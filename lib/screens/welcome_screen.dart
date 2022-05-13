import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final welcomeController = Get.put(WelcomeController());

    return Obx(
      () {
        return Scaffold(
          body: welcomeController.screens[welcomeController.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.generating_tokens_outlined),
                label: 'Genres',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: welcomeController.currentIndex.value,
            selectedItemColor: Colors.amber[800],
            onTap: (value) {
              welcomeController.currentIndex.value = value;
            },
          ),
        );
      },
    );
  }
}
