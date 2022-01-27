import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homemanager/models/checkauth.dart';
import 'package:homemanager/pages/editarFamilias.dart';
import 'package:homemanager/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:homemanager/pages/membrosFamilia.dart';
import 'package:homemanager/services/auth_service.dart';
import '/models/familiasDados.dart';
import 'editarFamilias.dart';
import 'package:shared_preferences/shared_preferences.dart';

class familias extends StatefulWidget {
  List<Famdados> dados = <Famdados>[];

  familias() {
    dados = [];
    // dados.add(Famdados(nome: 'Christian', adm: true));
    // dados.add(Famdados(nome: 'Ewerton', adm: false));
    // dados.add(Famdados(nome: 'Geovane', adm: false));
    // dados.add(Famdados(nome: 'Luis', adm: false));
  }

  @override
  _familiasState createState() => _familiasState();
}

class UserTeste {
  late final String nome;
  late final String email;

  UserTeste({
    required this.nome,
    required this.email,
  });

  Map<String, dynamic> ToJson() => {
        'nome': email,
      };

  static UserTeste fromJson(Map<String, dynamic> json) => UserTeste(
        nome: json['nome'],
        email: json['email'],
        //familias: json['familias'],
      );
}

class _familiasState extends State<familias> {
  var memCtrl = TextEditingController();

  // void navMembros(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => membrosFamilia(),
  //     ),
  //   );
  // }

  void createFam(String nome) async {
    final docUser = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(AuthService.to.user!.uid)
        .collection('familias')
        .doc();

    final docUser2 = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(AuthService.to.user!.uid);

    final snapshot = await docUser2.get();

    final user = UserTeste.fromJson(snapshot.data()!);

    docUser.set({
      'nome': nome,
      'uid': docUser.id,
    });

    final docFam =
        FirebaseFirestore.instance.collection('familias').doc(docUser.id);

    docFam.set({'nome': nome});

    final docFam2 = FirebaseFirestore.instance
        .collection('familias')
        .doc(docUser.id)
        .collection('Admins')
        .doc(AuthService.to.user!.uid);

    docFam2.set({'nome': user.nome, 'email': AuthService.to.user!.email});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suas Familias'),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Checkauth(),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Digite o nome da Familia:'),
                content: TextFormField(
                  controller: memCtrl,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      createFam(memCtrl.text);
                      Navigator.pop(context, 'Não');
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ),
            ),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.black87,
        child: StreamBuilder<List<familiasTeste>>(
            stream: lerFamilias(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final users = snapshot.data!;

                return ListView(
                  children: users.map<Widget>(buildFamilias).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),

        //
        // child: ElevatedButton(
        //     child: Text('update'),
        //     onPressed: () {
        //       final docUser = FirebaseFirestore.instance
        //           .collection('usuarios')
        //           .doc(AuthService.to.user!.uid)
        //           .collection('familias')
        //           .doc();

        //       print(docUser.id);

        //       docUser.set({
        //         'nome': 'alves',
        //         'uid': docUser.id,
        //       });

        //       final docFam = FirebaseFirestore.instance
        //           .collection('familias')
        //           .doc(docUser.id)
        //           .collection('Admins')
        //           .doc(AuthService.to.user!.uid);

        //       docFam.set({'email': AuthService.to.user!.email});
        //     }),
      ),
    );
  }
}

Widget buildFamilias(familiasTeste user) =>
    Builder(builder: (BuildContext context) {
      return ListTile(
        leading: Icon(
          Icons.family_restroom,
          size: 36,
          color: Colors.white,
        ),
        title: Text(
          user.nome,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        onTap: () {
          print(user.uid);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => membrosFamilia(
                codFam: user.uid,
                nomeFam: user.nome,
              ),
            ),
          );
        },
      );
    });

class familiasTeste {
  late final String nome;
  late final String uid;

  familiasTeste({
    required this.nome,
    required this.uid,
  });

  Map<String, dynamic> ToJson() => {
        'nome': nome,
        'uid': uid,
      };

  static familiasTeste fromJson(Map<String, dynamic> json) => familiasTeste(
        nome: json['nome'],
        uid: json['uid'],
      );
}

Stream<List<familiasTeste>> lerFamilias() => FirebaseFirestore.instance
    .collection('usuarios')
    .doc(AuthService.to.user!.uid)
    .collection('familias')
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => familiasTeste.fromJson(doc.data()))
        .toList());
