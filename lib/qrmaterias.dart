import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrMaterias extends StatefulWidget {
  final String infoMaterias;
  
  QrMaterias({this.infoMaterias});
  @override
  _QrMateriasState createState() => new _QrMateriasState();
 }
class _QrMateriasState extends State<QrMaterias> {
  @override
  Widget build(BuildContext context) {
              print(widget.infoMaterias);

   return new Scaffold(
  appBar: new AppBar(
    title: new Text("Materias docentes"),
    backgroundColor: Colors.redAccent,
  ),
  body: new Container(
    child: new Center(
      child: new Column(
        children: <Widget>[
          Text("Generar Código",
          style: TextStyle(fontSize: 24)),
          QrImage(
            data:widget.infoMaterias ,
            size: 250,
          ),
        ],
      ),
    ),
  ),
   );
  }
}