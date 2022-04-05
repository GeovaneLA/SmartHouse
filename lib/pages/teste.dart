import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
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

class Teste extends StatefulWidget {
  final String codFam;
  final String nomeFam;

  const Teste({Key? key, required this.codFam, required this.nomeFam})
      : super(key: key);

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  var macText = TextEditingController();

  void showdialog(String mac) {
    var nomeText = TextEditingController();
    showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Digite o nome que deseja atribuir ao dispositivo:'),
        content: TextFormField(
          controller: nomeText,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              final novoDipositivo = FirebaseFirestore.instance
                  .collection('familias')
                  .doc(widget.codFam)
                  .collection('Dispositivos')
                  .doc(mac);

              novoDipositivo
                  .set({'nome': nomeText.text}, SetOptions(merge: true));
              Navigator.pop(context, 'Não');
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.nomeFam}'),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              showDialog<String>(
                context: context,
                builder: (BuildContext context2) => AlertDialog(
                  title: const Text('Digite o endereço MAC do dispositivo:'),
                  content: TextFormField(
                    controller: macText,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        try {
                          BluetoothConnection connection =
                              await BluetoothConnection.toAddress(macText.text);
                          print('Connected to the device');

                          final novoDipositivo = FirebaseFirestore.instance
                              .collection('familias')
                              .doc(widget.codFam)
                              .collection('Dispositivos')
                              .doc(macText.text);

                          novoDipositivo.set({'mac_address': macText.text});
                          connection.finish();
                        } catch (exception) {
                          print('Cannot connect, exception occured');
                        }

                        Navigator.pop(context, 'Não');
                        showdialog(macText.text);
                      },
                      child: const Text('Adicionar'),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.add),
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
        child: StreamBuilder<List<Dispositivos>>(
            stream: LerDispositivos(widget.codFam),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final dispositivos = snapshot.data!;

                print(widget.codFam);

                return ListView(
                  children: dispositivos.map(buildDipositivos).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

Widget buildDipositivos(Dispositivos dispositivos) => Builder(builder: (
      BuildContext context,
    ) {
      return ListTile(
        leading: Icon(
          Icons.account_tree_outlined,
          color: Colors.white,
          size: 42,
        ),
        title: Text(
          dispositivos.nome,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          dispositivos.mac_address,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
        onTap: () async {
          try {
            BluetoothConnection connection =
                await BluetoothConnection.toAddress(dispositivos.mac_address);
            connection.output.add(ascii.encode('0'));
            await connection.output.allSent;

            connection.finish();
          } catch (Exception) {
            print('Cannot connect, exception occured');
          }
        },
        onLongPress: () async {},
      );
    });

class Dispositivos {
  late final String nome;
  late final String mac_address;

  Dispositivos({
    required this.nome,
    required this.mac_address,
  });

  Map<String, dynamic> ToJson() => {
        'nome': nome,
        'mac_address': mac_address,
      };

  static Dispositivos fromJson(Map<String, dynamic> json) => Dispositivos(
        nome: json['nome'],
        mac_address: json['mac_address'],
      );
}

Stream<List<Dispositivos>> LerDispositivos(String codFam) => FirebaseFirestore
    .instance
    .collection('familias')
    .doc(codFam)
    .collection('Dispositivos')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Dispositivos.fromJson(doc.data())).toList());
