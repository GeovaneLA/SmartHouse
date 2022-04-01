import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homemanager/models/checkauth.dart';
import 'package:homemanager/models/dispositivosDados.dart';
import 'package:homemanager/pages/dispositivos.dart';
import 'package:homemanager/pages/editarDispositivos.dart';
import 'package:homemanager/pages/editarFamilias.dart';
import 'package:homemanager/pages/familias.dart';
import 'package:homemanager/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:homemanager/services/auth_service.dart';
import '/models/familiasDados.dart';
import 'editarFamilias.dart';

class membrosFamilia extends StatefulWidget {
  final String codFam;
  final String nomeFam;

  membrosFamilia({Key? key, required this.codFam, required this.nomeFam})
      : super(key: key);

  @override
  _membrosFamiliaState createState() => _membrosFamiliaState();
}

class _membrosFamiliaState extends State<membrosFamilia> {
  var memCtrl = TextEditingController();

  validateUser(String text, String codFam, String nomeFam) async {
    String idUser = '';

    final docUser = await FirebaseFirestore.instance
        .collection('usuarios')
        .where('email', isEqualTo: text)
        .get();

    for (var doc in docUser.docs) {
      idUser = doc.id;
      print(idUser);
    }

    if (idUser == '') {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Usuario não encontrado'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Não');
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ));
    } else {
      final docUser =
          await FirebaseFirestore.instance.collection('usuarios').doc(idUser);

      final snapshot = await docUser.get();

      final user = UserTeste.fromJson(snapshot.data()!);

      final docFam = FirebaseFirestore.instance
          .collection('familias')
          .doc(codFam)
          .collection('Usuarios')
          .doc(idUser);

      final docFamUser = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(idUser)
          .collection('familias')
          .doc(codFam);

      docFam.set({
        'email': user.email,
        'familia': codFam,
        'nome': user.nome,
      });

      docFamUser.set({
        'nome': nomeFam,
        'uid': codFam,
      });

      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Usuario adicionado com sucesso'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Não');
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('${widget.nomeFam}'),
          backgroundColor: Colors.black87,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Teste(),
                  ),
                );
              },
              icon: Icon(Icons.account_tree_outlined),
            )
          ],
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

                  print(widget.codFam);

                  return ListView(
                    children: users.map(buildUser).toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Digite o email do usuario a ser adicionado:'),
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
                    validateUser(memCtrl.text, widget.codFam, widget.nomeFam);
                    memCtrl.text = '';
                    Navigator.pop(context, 'Não');
                  },
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black54,
          child: const Icon(Icons.add),
        ),
      );
}

Widget buildUser(UserTeste user) => Builder(builder: (
      BuildContext context,
    ) {
      return ListTile(
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
        trailing: Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
        onLongPress: () {
          var idUser;
          print(user.idFamilia);

          final docUser = FirebaseFirestore.instance
              .collection('familias')
              .doc(user.idFamilia)
              .collection('Admins')
              .doc(AuthService.to.user!.uid);

          docUser.get().then((docSnapshot) => {
                if (docSnapshot.exists)
                  {
                    showDialog<String>(
                      context: context,
                      builder: (
                        BuildContext context1,
                      ) =>
                          AlertDialog(
                        title: const Text(
                            'Deseja remover esse usuario da familia?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'Não');
                            },
                            child: const Text(
                              'Não',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final docUser = await FirebaseFirestore.instance
                                  .collection('familias')
                                  .doc(user.idFamilia)
                                  .collection('Usuarios')
                                  .where('email', isEqualTo: user.email)
                                  .get();

                              for (var doc in docUser.docs) {
                                idUser = doc.id;
                                print(idUser);
                              }

                              final deleteUserFam = await FirebaseFirestore
                                  .instance
                                  .collection('usuarios')
                                  .doc(idUser)
                                  .collection('familias')
                                  .doc(user.idFamilia)
                                  .delete();

                              final deleteUser = await FirebaseFirestore
                                  .instance
                                  .collection('familias')
                                  .doc(user.idFamilia)
                                  .collection('Usuarios')
                                  .doc(idUser)
                                  .delete();

                              Navigator.pop(context, 'Não');
                            },
                            child: const Text(
                              'Sim',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    )
                  }
                else
                  {
                    showDialog<String>(
                      context: context,
                      builder: (
                        BuildContext context,
                      ) =>
                          AlertDialog(
                        title: const Text(
                          'Apenas Admins podem remover membros',
                          textAlign: TextAlign.center,
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Ok',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    )
                  }
              });
        },
      );
    });

class UserTeste {
  late final String nome;
  late final String email;
  late final String idFamilia;
  //late final List familias;

  UserTeste({
    required this.nome,
    required this.email,
    required this.idFamilia,
    //required this.familias,
  });

  Map<String, dynamic> ToJson() => {
        'nome': nome,
        'email': email,
        'familia': idFamilia,
      };

  static UserTeste fromJson(Map<String, dynamic> json) => UserTeste(
        nome: json['nome'],
        email: json['email'],
        idFamilia: json['familia'],
      );
}

Stream<List<UserTeste>> readUsers(String codFam) => FirebaseFirestore.instance
    .collection('familias')
    .doc(codFam)
    .collection('Usuarios')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => UserTeste.fromJson(doc.data())).toList());

Future<UserTeste?> readUser(String codFam) async {
  final docUser = FirebaseFirestore.instance
      .collection('familias')
      .doc(codFam)
      .collection('Usuarios')
      .doc(AuthService.to.user!.uid);
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    return UserTeste.fromJson(snapshot.data()!);
  }
}
