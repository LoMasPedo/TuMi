import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipo2_grupo15/Pantallas/negocios.dart';
import 'package:equipo2_grupo15/Pantallas/registrarPedido.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class listaTiendas extends StatefulWidget {
  final String cedula;
  const listaTiendas({required this.cedula});

  @override
  _listaTiendasState createState() => _listaTiendasState();
}

class _listaTiendasState extends State<listaTiendas> {

  List negocios=[];
  List codigos=[];

  void initState(){
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    CollectionReference negocio = FirebaseFirestore.instance.collection("Negocios");
    String id="";
    QuerySnapshot datos = await negocio.get();
    if(datos.docs.length>0){
      for(var doc in datos.docs){
        id=doc.id.toString();
        codigos.add(id);
        negocios.add(doc.data());
      }
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIENDAS DISPONIBLES"),
      ),
      drawer: menu(),
      body: ListView.builder(
          itemCount: negocios.length,
          itemBuilder: (BuildContext context,i){
            return ListTile(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registrarPedido(id: codigos[i], cedula: widget.cedula)));
                },
              //  title: Card(url: negocios[i]['Foto'],texto: negocios[i]['nombre']+" "+negocios[i]['apellido']+'\n'+negocios[i]['correo'])

            );
          }),
    );
  }


}


