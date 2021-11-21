import 'dart:convert';
import 'package:homemanager/models/dispositivosDados.dart';
import 'package:flutter/material.dart';
import 'package:homemanager/pages/dispositvos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class editarDispositivos extends StatefulWidget {
  int index2;
  List<dispDados> dadosDisp = <dispDados>[];

  editarDispositivos({Key? key, required this.index2, required this.dadosDisp})
      : super(key: key);

  @override
  _editarDispositivosState createState() => _editarDispositivosState();
}

class _editarDispositivosState extends State<editarDispositivos> {
  void remove2(int index2) {
    setState(() {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => dispositivos(),
        ),
      );
      widget.dadosDisp.removeAt(index2);
      save();
    });
  }

  Future load() async {
    var prefs2 = await SharedPreferences.getInstance();
    var data2 = prefs2.getString('dataDisp');

    if (data2 != null) {
      Iterable decoded = jsonDecode(data2);
      List<dispDados> result2 =
          decoded.map((e) => dispDados.fromJson(e)).toList();
      setState(() {
        widget.dadosDisp = result2;
      });
    }
  }

  _editarDispositivosState() {
    load();
  }

  save() async {
    var prefs2 = await SharedPreferences.getInstance();
    await prefs2.setString('dataDisp', jsonEncode(widget.dadosDisp));
  }

  void acionamento() {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Dispositivo Acionado!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
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
                builder: (BuildContext context) => dispositivos(),
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
                  "Perfil: " + widget.dadosDisp[widget.index2].codigo != null
                      ? widget.dadosDisp[widget.index2].codigo
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
                child: Container(
                  height: 50,
                  width: 150,
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
                            "Remover",
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
                                  remove_circle_outline,
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
                          title: const Text('Deseja excluir esse dispositivo?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Não'),
                              child: const Text('Não'),
                            ),
                            TextButton(
                              onPressed: () {
                                remove2(widget.index2);
                              },
                              child: const Text('Sim'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                      Colors.blue.shade900,
                      Colors.blue,
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
                          "Acionar Dispositivo",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: Icon(
                            IconData(61418, fontFamily: 'MaterialIcons'),
                            color: Colors.white,
                          ),
                          height: 28,
                          width: 28,
                        ),
                      ],
                    ),
                    onPressed: acionamento,
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
