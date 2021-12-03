import 'package:equipo2_grupo15/Pantallas/RecibirMensaje.dart';
import 'package:flutter/material.dart';


class mensaje extends StatefulWidget {
  const mensaje({Key? key}) : super(key: key);

  @override
  _mensajeState createState() => _mensajeState();
}

class _mensajeState extends State<mensaje> {

  void initState(){

    super.initState();
    final objeto = new recibiendoMensajes();
    objeto.notificaciones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  Color(0xFF61D5D4),
                  Color(0xFFFF6961)
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )
          ),
        ),
        title: Text("Notificaciones"),
      ),
    );
  }
}
