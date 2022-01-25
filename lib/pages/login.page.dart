import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homemanager/pages/homepage.dart';
import 'package:homemanager/pages/reset-password.dart';
import 'package:homemanager/pages/signup.page.dart';
import 'package:homemanager/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var login = TextEditingController();

  var senha = TextEditingController();

  bool loading = false;

  void checkLogin() {
    setState(() {
      loading = true;
    });
    AuthService.to.login(login.text, senha.text);
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        loading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login ou senha incorretos!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
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
              controller: login,
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
            SizedBox(
              height: 20,
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
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Recuperar Senha",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordPage(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 40,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: (loading)
                        ? [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ]
                        : [
                            Text(
                              "Entrar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            // Container(
                            //   child: Image.asset('assets/login.png'),
                            //   height: 28,
                            //   width: 28,
                            // ),
                          ],
                  ),
                  onPressed: checkLogin,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 60,
            //   alignment: Alignment.centerLeft,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(5),
            //     ),
            //   ),
            //   child: SizedBox.expand(
            //     child: FlatButton(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Text(
            //             "Entrar com o Google",
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black,
            //               fontSize: 20,
            //             ),
            //             textAlign: TextAlign.left,
            //           ),
            //           Container(
            //             child: Image.asset('assets/google.png'),
            //             height: 28,
            //             width: 28,
            //           ),
            //         ],
            //       ),
            //       onPressed: () => {},
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              child: FlatButton(
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
