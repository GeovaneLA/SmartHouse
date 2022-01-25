import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homemanager/models/checkauth.dart';
import 'package:homemanager/models/dispositivosDados.dart';
import 'package:homemanager/pages/editarDispositivos.dart';
import 'package:homemanager/pages/editarFamilias.dart';
import 'package:homemanager/pages/familias.dart';
import 'package:homemanager/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:homemanager/services/auth_service.dart';
import '/models/familiasDados.dart';
import 'editarFamilias.dart';
import 'package:shared_preferences/shared_preferences.dart';

class membrosFamilia extends StatefulWidget {
  @override
  _membrosFamiliaState createState() => _membrosFamiliaState();
}

class _membrosFamiliaState extends State<membrosFamilia> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
        ),
        body: StreamBuilder<List<UserTeste>>(
            stream: readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final users = snapshot.data!;

                return ListView(
                  children: users.map(buildUser).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        // body: FutureBuilder<UserTeste?>(
        //     future: readUser(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         final user = snapshot.data;

        //         return user == null
        //             ? Center(child: Text('Sem usuario'))
        //             : buildUser(user);
        //       } else {
        //         return Center(child: CircularProgressIndicator());
        //       }
        //     })
        // body: ElevatedButton(
        //   child: Text('update'),
        //   onPressed: () {
        //     final docUser = FirebaseFirestore.instance
        //         .collection('usuarios')
        //         .doc(AuthService.to.user!.uid);

        //     var list = ['teste1'];
        //     docUser.update({'familias': FieldValue.arrayUnion(list)});
        //   },
        // ),
      );
}

Widget buildUser(UserTeste user) => ListTile(
      leading: CircleAvatar(),
      title: Text(user.nome),
      subtitle: Text(user.email),
    );

class UserTeste {
  late final String nome;
  late final String email;
  //late final List familias;

  UserTeste({
    required this.nome,
    required this.email,
    //required this.familias,
  });

  Map<String, dynamic> ToJson() => {
        'nome': nome,
        'email': email,
      };

  static UserTeste fromJson(Map<String, dynamic> json) => UserTeste(
        nome: json['nome'],
        email: json['email'],
        //familias: json['familias'],
      );
}

Stream<List<UserTeste>> readUsers() => FirebaseFirestore.instance
    .collection('familias')
    .doc('XHfJCF1XPbHrHPWEOtMz')
    .collection('Admins')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => UserTeste.fromJson(doc.data())).toList());

Future<UserTeste?> readUser() async {
  final docUser = FirebaseFirestore.instance
      .collection('familias')
      .doc('XHfJCF1XPbHrHPWEOtMz')
      .collection('Admins')
      .doc('cIZxbEhO0IOEq5WAptDt68pIKKg2');
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    return UserTeste.fromJson(snapshot.data()!);
  } else {
    print('teste');
  }
}
