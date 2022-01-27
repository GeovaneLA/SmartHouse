import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homemanager/pages/dispositvos.dart';
import 'package:homemanager/pages/familias.dart';
import 'package:homemanager/pages/membrosFamilia.dart';
import 'package:homemanager/services/auth_service.dart';

Widget buildUser(UserTeste user) => Text(
      'Bem-vindo, ${user.nome}',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 36,
        color: Colors.white,
      ),
    );

class UserTeste {
  late final String nome;
  late final String email;

  UserTeste({
    required this.nome,
    required this.email,
  });

  Map<String, dynamic> ToJson() => {
        'nome': nome,
        'email': email,
      };

  static UserTeste fromJson(Map<String, dynamic> json) => UserTeste(
        nome: json['nome'],
        email: json['email'],
      );
}

Stream<List<UserTeste>> readUsers() => FirebaseFirestore.instance
    .collection('usuarios')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => UserTeste.fromJson(doc.data())).toList());

Future<UserTeste?> readUser() async {
  final docUser = FirebaseFirestore.instance
      .collection('usuarios')
      .doc(AuthService.to.user!.uid);
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    return UserTeste.fromJson(snapshot.data()!);
  }
}

void NavFamilias(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => familias(),
    ),
  );
}

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      drawer: Drawer(
        child: Material(
          color: Colors.black87,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              const SizedBox(
                height: 78,
              ),
              buildMenuItem(
                text: 'Perfil',
                icon: Icons.person,
              ),
              const SizedBox(
                height: 28,
              ),
              buildMenuItem(
                text: 'Convites',
                icon: Icons.mail_outline,
              ),
              const SizedBox(
                height: 28,
              ),
              buildMenuItem(
                text: 'Gerenciar Familias',
                icon: Icons.people,
              ),
              const SizedBox(
                height: 28,
              ),
              buildMenuItem(
                text: 'Gerenciar Dispositivos',
                icon: Icons.account_tree_outlined,
              ),
              const SizedBox(height: 14),
              const Divider(
                thickness: 0.1,
                color: Colors.white70,
              ),
              const SizedBox(height: 14),
              buildMenuItem(
                text: 'Sair',
                icon: Icons.logout_outlined,
              ),
              const SizedBox(height: 14),
              const Divider(
                thickness: 0.1,
                color: Colors.white70,
              ),
              const SizedBox(height: 14),
              buildMenuItem(
                text: 'O que há de novo',
                icon: Icons.update_outlined,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 40,
          right: 40,
        ),
        color: Colors.black87,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
                child: FutureBuilder<UserTeste?>(
                    future: readUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final user = snapshot.data;

                        return user == null
                            ? Center(child: Text('Sem usuario'))
                            : buildUser(user);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
            SizedBox(
              height: 150,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Gerenciar Familia",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                        height: 28,
                        width: 28,
                      ),
                    ],
                  ),
                  onPressed: () => {
                    NavFamilias(context),
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Gerenciar Dispositivos",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: Icon(
                          Icons.account_tree_outlined,
                          color: Colors.white,
                        ),
                        height: 28,
                        width: 28,
                      ),
                    ],
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => dispositivos(),
                      ),
                    ),
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
                        "Sair",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        height: 28,
                        width: 28,
                      ),
                    ],
                  ),
                  onPressed: () => {AuthService.to.logout()},
                ),
              ),
            ),
          ],
        ),
      ),
      // body: FutureBuilder<User?>(
      //   future: readUser(),
      //   builder: (context, snapshot){},
      // )
    );
  }

  // FutureBuilder<User?> readUser() async{
  //   final docUser = FirebaseFirestore.instance.collection('usuarios').doc(AuthService.to.user!.uid);
  //   final snapshot = await docUser.get();

  //   if (snapshot.exists){
  //     return User.fromJson(snapshot.data()!);
  //   }
  // }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
  }) {
    final color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      onTap: () {},
    );
  }
}
