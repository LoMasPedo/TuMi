import 'package:equipo2_grupo15/Pantallas/loginCliente.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class negocios extends StatefulWidget {

  @override
  State<negocios> createState() => _negociosState();
}

class _negociosState extends State<negocios> {

  List datos_negocios=[];

  void initState(){
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    CollectionReference datos= FirebaseFirestore.instance.collection('Negocios'); //Conecta a la conexion
    QuerySnapshot negocios= await datos.get(); //Traer todas los ngocios
    if(negocios.docs.length>0){
      print('Trae datos');

      for(var doc in negocios.docs){
        print(doc.data());
        datos_negocios.add(doc.data());

      }
    }else{
      print('ha fallado....');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('Listado de negocios'),
      ),

      body: Center(
            child: ListView.builder(
                  itemCount: datos_negocios.length,
                  itemBuilder: (BuildContext context, i){
                    return ListTile(
                      title: Text('Negocio '+i.toString()+' - '+datos_negocios[i]['Nombre'].toString()),
                    );
                    boton();
                    },
                ),
      ),
    );

  }
}


class boton extends StatefulWidget {

  @override
  _botonState createState() => _botonState();
}

class _botonState extends State<boton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(onPressed: (){

        },child:
        Text('Consultar'),
            style: ElevatedButton.styleFrom(
                primary: Colors.cyan)
        ),
    );
  }
}




