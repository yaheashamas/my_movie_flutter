import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/auth_controller.dart';
import 'package:movies/screens/favorite_screen.dart';
import 'package:movies/screens/login_screen.dart';
import 'package:movies/screens/register_screen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: authController.isLogIn.value == false
              ? [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Login', textScaleFactor: 1),
                    onTap: () => Get.to(LoginScreen()),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add_rounded),
                    title: Text('Register', textScaleFactor: 1),
                    onTap: () => Get.to(RegisterScreen()),
                  )
                ]
              : [
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Favorite', textScaleFactor: 1),
                    onTap: () => Get.to(FavoriteScreen()),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log Out', textScaleFactor: 1),
                  )
                ],
        ),
      ),
    );
  }
}
