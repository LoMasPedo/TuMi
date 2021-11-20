import 'package:equipo2_grupo15/Pantallas/productos.dart';
import 'package:flutter/material.dart';
import 'package:equipo2_grupo15/Pantallas/negocios.dart';
import 'package:equipo2_grupo15/Pantallas/consultaNegocios.dart';
//import 'package:equipo2_grupo15/Pantallas/consultaProductos.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

import 'bienvenida.dart';

class seleccionCliente extends StatefulWidget {
  const seleccionCliente({Key? key}) : super(key: key);

  @override
  _seleccionClienteState createState() => _seleccionClienteState();
}

class _seleccionClienteState extends State<seleccionCliente> {

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            child:
            imagen(url: "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/TuMI.png"),
          ),
          Container(
            child:
            next1(),
          ),
          Container(
            child:
            next2(),
          ),
        ],
      ),
    );
  }
}

class next1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child:
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> negocios() ));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Negocios '),
                  //Icon(Icons.arrow_forward_sharp)
                ],
              )
          )
      ),
    );

  }
}
class next2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child:
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>productos() /*aqui va productos*/  ));//Aca toca cambiarlo por el de productos cuando este.
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Productos'),
                  //Icon(Icons.arrow_forward_sharp)
                ],
              )
          )
      ),
    );


  }
}
class imagen extends StatelessWidget {
  final String url;
  const imagen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0,20.0),
      child: Image.network(url,scale:2),
    );
  }
}
/*class login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        ElevatedButton(
            onPressed: (){
              //aqui se pone el salto de pagina
              Navigator.push(context, MaterialPageRoute(builder: (context)=>negocios()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Login'),
                Icon(Icons.arrow_forward_sharp)
              ],
            )
        )
    );

  }
}*/