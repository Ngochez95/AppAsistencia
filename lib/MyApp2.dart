import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_scanner/MyApp.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApp2 extends StatefulWidget {
  final String user, idMateria, idUsuario;
  MyApp2({this.user, this.idMateria, this.idUsuario});
  @override
  _MyApp2State createState() => new _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  String _reader = '';
  Permission permission = Permission.Camera;
  final uri = 'http://35.232.215.93/apis/asistencia.php';

  requestPermission() async {
    bool result =
        (await SimplePermissions.requestPermission(permission)) as bool;
  }

  scan() async {
    try {
      String reader = await BarcodeScanner.scan();
      if (!mounted) {
        return;
      }
      if (reader == widget.user) {
        var jsonM = '{"id_usuario":"' +
            widget.idUsuario +
            '", "id_materia":"' +
            widget.idMateria +
            '"}';
        print(jsonM);
        final postM = await http.post(uri, body: jsonM);
        int codigo = postM.statusCode;
        print(codigo);
        if (codigo == 200) {
        setState(() => _reader = 'Asistencia marcada con Exito!');
        }
        if (codigo == 404 || codigo == 400) {
        setState(() => _reader = 'Algo va mal');          
        }
        
      } else {
        setState(() => _reader = 'Sin coincidencias');        
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        requestPermission();
      } else {
        setState(() => _reader = "Error desconocido $e");
      }
    } on FormatException {
      setState(
          () => _reader = "Escanea tu codigo para completar tu asistencia");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Asistencia'),
        backgroundColor: Colors.red,
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            new RaisedButton(
              splashColor: Colors.pinkAccent,
              color: Colors.red,
              child: new Text(
                "Marcar Asistencia",
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: scan,
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            new Text(
              '$_reader',
              softWrap: true,
              style: new TextStyle(fontSize: 30.0, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
