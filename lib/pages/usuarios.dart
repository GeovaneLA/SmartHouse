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

class usuarios extends StatefulWidget {
  @override
  _usuariosState createState() => _usuariosState();
}

class _usuariosState extends State<usuarios> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Usuarios'),
    );
  }
}
