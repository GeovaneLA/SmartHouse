import 'package:flutter/material.dart';
import 'package:homemanager/models/checkauth.dart';
import 'package:homemanager/services/auth_service.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var nome = TextEditingController();

  var email = TextEditingController();

  var senha = TextEditingController();

  var ConfirmarSenha = TextEditingController();

  cadastrar() {
    if (senha.text == ConfirmarSenha.text) {
      AuthService.to.createUser(email.text, senha.text, nome.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Checkauth(),
        ),
      );
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'As senhas não são iguais!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 40, left: 40, right: 40),
        color: Colors.black87,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/home_manager.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nome,
              // autofocus: true,
              keyboardType: TextInputType.text,
              //autovalidateMode: AutovalidateMode.always,
              decoration: InputDecoration(
                labelText: "Usuario",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            TextFormField(
              controller: email,
              // autofocus: true,
              keyboardType: TextInputType.emailAddress,
              //autovalidateMode: AutovalidateMode.always,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            TextFormField(
              controller: senha,
              // autofocus: true,
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            TextFormField(
              controller: ConfirmarSenha,
              // autofocus: true,
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirmar Senha",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Colors.lightBlue.shade900,
                    Colors.lightBlue,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: cadastrar,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
