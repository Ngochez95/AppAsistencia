import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'dart:async';
import 'dart:convert';
import 'MyApp2.dart';

class list extends StatefulWidget {
final String Usuario;
list({this.Usuario});
  @override
  _listState createState() => new _listState();
 }
class _listState extends State<list> {
Map data;
List userData;


  Future getData() async{
    http.Response response= await http.get("http://35.232.215.93/apis/materias.php?user=${widget.Usuario}");
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
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
       backgroundColor:Colors.redAccent,
     ),
   body: ListView.builder(
     itemCount: userData ==null ? 0 : userData.length ,
     itemBuilder: (BuildContext contex, int index){
       return Card(
         margin: EdgeInsets.all(8.0),
         child: new InkWell(
           onTap: (){
             Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new MyApp2(user: userData[index]["codigo"],)));
           },
           splashColor: Colors.red,
           child: Row(
           children: <Widget>[
             CircleAvatar(
               maxRadius: 30,
               backgroundColor: Colors.redAccent,
               child: new Text(userData[index]["codigo"].toString()),
               backgroundImage: NetworkImage(userData[index]["nombre_materia"]),
             ),
             Text("  "+ "${userData[index]["nombre_materia"]}" ),
           ],
         ),
         ),
       );
     },
   ),
   );
  }
}