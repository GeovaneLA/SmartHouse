import 'dart:convert';

import 'package:flutter/material.dart';
import '/models/familiasDados.dart';
import 'familias.dart';
import 'package:shared_preferences/shared_preferences.dart';

class editarFamilias extends StatefulWidget {
  int index;
  List<Famdados> dados = <Famdados>[];

  editarFamilias({Key? key, required this.index, required this.dados})
      : super(key: key);

  @override
  _editarFamiliasState createState() => _editarFamiliasState();
}

class _editarFamiliasState extends State<editarFamilias> {
  void remove(int index) {
    setState(() {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => familias(),
        ),
      );
      widget.dados.removeAt(index);
      save();
    });
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
      print(widget.dados[widget.index].nome);
    }
  }

  _editarFamiliasState() {
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
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => familias(),
              ),
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.black87,
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(
                  "Perfil: " + widget.dados[widget.index].nome != null
                      ? widget.dados[widget.index].nome
                      : '123',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: CheckboxListTile(
                  title: Text(
                    "Administrador",
                    style: TextStyle(color: Colors.white),
                  ),
                  key: Key(widget.dados[widget.index].nome),
                  value: widget.dados[widget.index].adm,
                  onChanged: (value) {
                    setState(() {
                      widget.dados[widget.index].adm = value!;
                      save();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                height: 70,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Colors.red.shade900,
                      Colors.red,
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: SizedBox.expand(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Remover Membro",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: Icon(
                            Icons. //highlight_remove,
                                person_remove_alt_1_rounded,
                            color: Colors.white,
                          ),
                          height: 28,
                          width: 28,
                        ),
                      ],
                    ),
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Deseja excluir esse membro?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Não'),
                            child: const Text('Não'),
                          ),
                          TextButton(
                            onPressed: () {
                              remove(widget.index);
                            },
                            child: const Text('Sim'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
