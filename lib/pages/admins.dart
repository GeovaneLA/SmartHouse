import 'dart:convert';
import 'package:homemanager/models/checkauth.dart';
import 'package:homemanager/models/dispositivosDados.dart';
import 'package:homemanager/pages/editarDispositivos.dart';
import 'package:homemanager/pages/editarFamilias.dart';
import 'package:homemanager/pages/homepage.dart';
import 'package:flutter/material.dart';
import '/models/familiasDados.dart';
import 'editarFamilias.dart';
import 'package:shared_preferences/shared_preferences.dart';

class admins extends StatefulWidget {
  final String codFam;
  final String nomeFam;

  admins({Key? key, required this.codFam, required this.nomeFam})
      : super(key: key);

  @override
  _adminsState createState() => _adminsState();
}

class _adminsState extends State<admins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          //   padding: EdgeInsets.only(
          //     top: 60,
          //     left: 20,
          //     right: 40,
          //   ),
          //   color: Colors.black87,
          //   child: StreamBuilder<List<UserTeste>>(
          //       stream: readUsers(widget.codFam),
          //       builder: (context, snapshot) {
          //         if (snapshot.hasData) {
          //           final users = snapshot.data!;

          //           return ListView(
          //             children: users.map(buildUser).toList(),
          //           );
          //         } else {
          //           return Center(child: CircularProgressIndicator());
          //         }
          //       }),
          ),
    );
  }
}
