import 'dart:convert';
import 'package:homemanager/models/dispositivosDados.dart';
import 'package:homemanager/pages/editarDispositivos.dart';
import 'package:homemanager/pages/editarFamilias.dart';
import 'package:homemanager/pages/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '/models/familiasDados.dart';
import 'editarFamilias.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dispositivos extends StatefulWidget {
  List<dispDados> dadosDisp = <dispDados>[];

  dispositivos() {
    dadosDisp = [];
    // dados.add(Famdados(nome: 'Christian', adm: true));
    // dados.add(Famdados(nome: 'Ewerton', adm: false));
    // dados.add(Famdados(nome: 'Geovane', adm: false));
    // dados.add(Famdados(nome: 'Luis', adm: false));
  }

  @override
  _dispositivosState createState() => _dispositivosState();
}

class _dispositivosState extends State<dispositivos> {
  var memCtrl = TextEditingController();

  void add() {
    if (memCtrl.text.isEmpty) return;

    setState(() {
      widget.dadosDisp.add(dispDados(codigo: memCtrl.text));
      save();
      memCtrl.text = "";
    });
  }

  Future load() async {
    var prefs2 = await SharedPreferences.getInstance();
    var dataDisp = prefs2.getString('dataDisp');

    if (dataDisp != null) {
      Iterable decoded = jsonDecode(dataDisp);
      List<dispDados> result =
          decoded.map((e) => dispDados.fromJson(e)).toList();
      setState(() {
        widget.dadosDisp = result;
      });
    }
  }

  _dispositivosState() {
    load();
  }

  save() async {
    var prefs2 = await SharedPreferences.getInstance();
    await prefs2.setString('dataDisp', jsonEncode(widget.dadosDisp));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => homepage(),
              ),
            );
          },
        ),
        title: TextFormField(
          controller: memCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            labelText: "Adicionar Dispositivos",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: add,
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
        child: Container(
          child: new ListView.builder(
            itemCount: widget.dadosDisp != null ? widget.dadosDisp.length : 0,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  widget.dadosDisp[i].codigo,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => editarDispositivos(
                        index2: i,
                        dadosDisp: widget.dadosDisp,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
