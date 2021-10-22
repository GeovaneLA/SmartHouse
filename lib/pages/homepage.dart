import 'package:flutter/material.dart';
import 'package:homemanager/pages/dispositvos.dart';
import 'package:homemanager/pages/familias.dart';

class homepage extends StatelessWidget {
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
                "Bem-vindo!",
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => familias(),
                      ),
                    );
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
