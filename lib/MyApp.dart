import 'dart:convert';

import 'package:flutter/material.dart';
import 'MyApp2.dart';
import 'materias.dart';
import 'profile.dart';
import 'main.dart';
import 'crearMaterias.dart';
import 'materiasDocente.dart';

class MyApp extends StatefulWidget {
  final Map correo;
  MyApp({this.correo});
//Map<String, dynamic> user=jsonDecode(correo);
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List userData;
  bool ver;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userData = widget.correo["data"];
    });
    if (userData[0]["id_tipo_usuario"] == "3") {
      ver = true;
    } else {
      ver = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Asistencia UES"),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white70,
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('${userData[0]["user"]}'),
              accountEmail: new Text('${userData[0]["email"]}'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: new NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTWwa83KBPQkFXW-JL0LEyBnifwd4t1bBzLU5S8uvnam-6daSvc"),
              ),
              decoration: new BoxDecoration(color: Colors.redAccent),
            ),
            new ListTile(
              leading: Icon(Icons.person),
              title: new Text("Perfil"),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new MyHomePage(
                              user: userData,
                            )));
              },
            ),
            new ListTile(
              leading: Icon(Icons.adjust),
              title: new Text("Ajuste"),
            ),
            new ListTile(
              leading: Icon(Icons.lock),
              title: new Text("Cerrar Sesión"),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Login()));
              },
            ),
          ],
        ),
      ),
      body: new Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            new Card(
              margin: EdgeInsets.all(8.0),
              child: new InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new MyHomePage(
                                user: userData,
                              )));
                },
                splashColor: Colors.red,
                child: new Center(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(Icons.people, size: 70.0),
                      Text(
                        "Perfil",
                        style: new TextStyle(fontSize: 17.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Card(
              child: new InkWell(
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new list(Usuario: userData[0]["id_usuario"],)));
                },
                splashColor: Colors.red,
                child: new Center(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(Icons.check_box, size: 70.0),
                      Text(
                        "Asistencia",
                        style: new TextStyle(fontSize: 17.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Card(
              child: new InkWell(
                onTap: () {},
                splashColor: Colors.red,
                child: new Center(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(Icons.star, size: 70.0),
                      Text(
                        "Insignias",
                        style: new TextStyle(fontSize: 17.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Card(
              child: new InkWell(
                onTap: () {},
                splashColor: Colors.red,
                child: new Center(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(Icons.card_travel, size: 70.0),
                      Text(
                        "Rutas",
                        style: new TextStyle(fontSize: 17.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Visibility(
              visible: ver,
              child: new Card(
                margin: EdgeInsets.all(8.0),
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new materiasDocentes(idDocente:"${userData[0]["id_usuario"].toString()}")));
                  },
                  splashColor: Colors.red,
                  child: new Center(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Icon(Icons.library_books, size: 70.0),
                        Text(
                          "Mis Materias",
                          style: new TextStyle(fontSize: 17.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            new Visibility(
              visible: ver,
              child: new Card(
                margin: EdgeInsets.all(8.0),
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new CrearMaterias()));
                  },
                  splashColor: Colors.red,
                  child: new Center(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Icon(Icons.book, size: 70.0),
                        Text(
                          "Crear Materias",
                          style: new TextStyle(fontSize: 17.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
