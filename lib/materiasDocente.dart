import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'MyApp2.dart';

class materiasDocentes extends StatefulWidget {
  final String idDocente;
  materiasDocentes({this.idDocente});
  @override
  _materiasDocentesState createState() => new _materiasDocentesState();
}

class _materiasDocentesState extends State<materiasDocentes> {
  Map data;
  List userData;
  List matDocentes;

  Future getData() async {
    http.Response response =
        await http.get("http://35.232.215.93/apis/materias.php");
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
      for (int i = 0; i < userData.length; i++) {
       if (userData[i]["id_usuario"].toString() != widget.idDocente) {
         userData.remove("id_materia");
         print("\n\n\n");
         print(userData[0][0]);
        //  userData.remove(userData[0]);
          //wzamora@gmail.com
        }
      }
      print(userData.length);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Materias"),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext contex, int index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: new InkWell(
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new MyApp2()));
              },
              splashColor: Colors.red,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 28,
                    backgroundColor: Colors.blueAccent,
                    // backgroundImage: userData[index]["codigo"],
                    child: new Text(userData[index]["codigo"].toString()),
                  ),
                  Text(
                    "  " + "${userData[index]["nombre_materia"]}",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
