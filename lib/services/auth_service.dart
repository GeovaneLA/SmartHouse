import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homemanager/database/db_firestore.dart';
import 'package:homemanager/models/user.dart';
import 'package:homemanager/pages/login.page.dart';

class AuthService extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  var userAuth = false.obs;
  var collection = FirebaseFirestore.instance.collection('usuarios');
  bool loading = false;

  @override
  void onInit() {
    super.onInit();

    _firebaseUser.bindStream(_auth.authStateChanges());

    ever(_firebaseUser, (User? user) {
      // ignore: unnecessary_null_comparison
      if (user != null) {
        userAuth.value = true;
      } else {
        userAuth.value = false;
      }
    });
  }

  User? get user => _firebaseUser.value;
  static AuthService get to => Get.find<AuthService>();

  showSnack(String titulo, String erro) {
    Get.snackbar(
      titulo,
      erro,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  createUser(String email, String senha, String nome) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      collection.doc(AuthService.to.user!.uid).set({
        'nome': nome,
        'email': email,
        'familias': [],
      });
    } catch (e) {
      showSnack('Erro ao registrar', e.toString());
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
    } catch (e) {
      showSnack('Erro ao logar', e.toString());
    }
  }

  logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      showSnack('Erro ao Sair', e.toString());
    }
  }
}
