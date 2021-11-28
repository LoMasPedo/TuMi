import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import 'package:equipo2_grupo15/Pantallas/negocios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class registrarPedido extends StatefulWidget {
  final String id,cedula;
  const registrarPedido({required this.id, required this.cedula});

  @override
  _registrarPedidoState createState() => _registrarPedidoState();
}

class _registrarPedidoState extends State<registrarPedido> {
  List listaCursos=[];
  List codigosGustos=[];

  void initState(){
    super.initState();
    getCursos();
  }

  void getCursos() async {
    CollectionReference gustos = FirebaseFirestore.instance.collection("Gustos");
    String cod="";
    QuerySnapshot cursos= await gustos.where("persona", isEqualTo: widget.id).get();
    if(cursos.docs.length>0){
      for(var doc in cursos.docs){
        cod=doc.id.toString();
        codigosGustos.add(cod);
        listaCursos.add(doc.data());
      }
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Regsitrar Pedido"),
        ),
        drawer: menu(),
        body: ListView.builder(
            itemCount: listaCursos.length,
            itemBuilder: (BuildContext context,i){
              var can = TextEditingController();
              return ListTile(
                leading: Icon(Icons.add_box, size: 30,color: Colors.blue),
                title: Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.yellow,
                  child: Text(listaCursos[i]['nombre']+" - "+listaCursos[i]['descripcion']+" - "+listaCursos[i]['precio'].toString()),
                ),
                subtitle: TextField(
                  controller: can,
                  decoration: InputDecoration(
                      hintText: "Cant."
                  ),
                ),
                onTap: (){
                  print("Cantidad: "+can.text);
                  print("Precio: "+listaCursos[i]['precio'].toString());
                  print(int.parse(can.text)*(int.parse(listaCursos[i]['precio'].toString())));
                },
              );
            })

    );
  }
}
