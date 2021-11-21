import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemanager/pages/familias.dart';
import 'package:homemanager/pages/homepage.dart';
import 'package:homemanager/pages/login.page.dart';
import 'package:homemanager/services/auth_service.dart';

class Checkauth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => AuthService.to.userAuth.value ? homepage() : LoginPage());
  }
}
