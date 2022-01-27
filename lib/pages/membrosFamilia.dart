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
  final String codFam;
  final String nomeFam;

  membrosFamilia({Key? key, required this.codFam, required this.nomeFam})
      : super(key: key);

  @override
  _membrosFamiliaState createState() => _membrosFamiliaState();
}

class _membrosFamiliaState extends State<membrosFamilia> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('${widget.nomeFam}'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 20,
          right: 40,
        ),
        color: Colors.black87,
        child: StreamBuilder<List<UserTeste>>(
            stream: readUsers(widget.codFam),
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
      ));
}

Widget buildUser(UserTeste user) => ListTile(
      leading: Icon(
        Icons.account_circle,
        color: Colors.white,
        size: 42,
      ),
      title: Text(
        user.nome,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        user.email,
        style: TextStyle(color: Colors.white),
      ),
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
      );
}

Stream<List<UserTeste>> readUsers(String codFam) => FirebaseFirestore.instance
    .collection('familias')
    .doc(codFam)
    .collection('Admins')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => UserTeste.fromJson(doc.data())).toList());

Future<UserTeste?> readUser(String codFam) async {
  final docUser = FirebaseFirestore.instance
      .collection('familias')
      .doc(codFam)
      .collection('Admins')
      .doc(AuthService.to.user!.uid);
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    return UserTeste.fromJson(snapshot.data()!);
  }
}
