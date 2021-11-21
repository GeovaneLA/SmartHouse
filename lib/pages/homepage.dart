import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homemanager/pages/dispositvos.dart';
import 'package:homemanager/pages/familias.dart';
import 'package:homemanager/services/auth_service.dart';

// Future<String> pesquisar() async {
//   var collection = FirebaseFirestore.instance.collection('usuarios');

//   var result = await collection.get();

//   var nome;

//   for (var doc in result.docs) {
//     if (doc.id == AuthService.to.user!.uid) {
//       nome = doc['nome'];
//     }
//   }
//   return nome;
// }

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
                height: 48,
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
            Container(
              child: Text(
                AuthService.to.user!.email!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
            ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => familias(),
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
                          Icons.account_tree_outlined,
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
    );
  }

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
