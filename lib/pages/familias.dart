import 'dart:convert';
import 'package:homemanager/pages/editarFamilias.dart';
import 'package:homemanager/pages/homepage.dart';
import 'package:http/http.dart' as http;
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
  // var item;

  // _listarUsuarios() async {
  //   final url = "http://192.168.56.1/flutter/dados/usuarios.php";
  //   final response = await http.get(url);
  //   final map = json.decode(response.body);
  //   final itens = map["result"];
  //   this.dados = itens;
  //   print(this.dados);
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _listarUsuarios();
  // }

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
            labelText: "Adicionar membro",
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
