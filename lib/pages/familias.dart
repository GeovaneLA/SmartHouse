import 'dart:convert';
import 'package:homemanager/models/checkauth.dart';
import 'package:homemanager/pages/editarFamilias.dart';
import 'package:homemanager/pages/homepage.dart';
import 'package:flutter/material.dart';
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

class _familiasState extends State<familias> {
  var memCtrl = TextEditingController();

  void add() {
    if (memCtrl.text.isEmpty) return;

    setState(() {
      widget.dados.add(Famdados(nome: memCtrl.text, adm: false));
      save();
      memCtrl.text = "";
    });
    print(widget.dados[0].adm);
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Famdados> result = decoded.map((x) => Famdados.fromJson(x)).toList();
      setState(() {
        widget.dados = result;
      });
    }
  }

  _familiasState() {
    load();
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.dados));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                title: const Text('Digite o nome do membro a ser adicionado'),
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
                      add();
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
        child: Container(
          child: new ListView.builder(
            itemCount: widget.dados != null ? widget.dados.length : 0,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  widget.dados[i].nome,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: widget.dados[i].adm == true
                    ? Text(
                        "Administrador",
                        style: TextStyle(color: Colors.white),
                      )
                    : Text(
                        'Normal',
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
                      builder: (context) => editarFamilias(
                        index: i,
                        dados: widget.dados,
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
