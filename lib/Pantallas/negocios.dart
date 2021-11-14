import 'package:equipo2_grupo15/Pantallas/loginCliente.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipo2_grupo15/Pantallas/consultaNegocios.dart';
import 'dart:convert';



class negocios extends StatefulWidget {


  TextEditingController idbusqueda=TextEditingController();
  @override

  State<negocios> createState() => _negociosState();
}

class _negociosState extends State<negocios> {

  List datos_negocios=[];
  String idbusqueda="";
  void initState(){
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    CollectionReference datos= FirebaseFirestore.instance.collection('Negocios'); //Conecta a la conexion
    QuerySnapshot negocios= await datos.get(); //Traer todas los ngocios
    if(negocios.docs.length>0){
      //print('Trae datos getNegocios');

      for(var doc in negocios.docs){
       // print(doc.data());
        setState(() {
        datos_negocios.add(doc.data());
        });
       // print('agregar datos negocio');

      }
    }else{
      print('ha fallado....');
    }
  }

  void getNegociosConParametro(String palabra) async {
    setState(() {
      datos_negocios=[];
    });
    CollectionReference datos= FirebaseFirestore.instance.collection('Negocios');
    QuerySnapshot negocios= await datos.get();
    //En el momento no encontre en las clases como hacer una busqeuda de texto en firebase realice un filtro.
    if(negocios.docs.length>0){
      for(var doc in negocios.docs){
        var data =  doc.data();
        if(doc.get("Nombre").toLowerCase().indexOf(palabra.toLowerCase())!=-1){
          //print("si ahy concidencia");
          setState(() {
            datos_negocios.add(doc.data());
          });
        }


      }
    }else{
      print('no se encontraron negocios....');
    }

  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(

        title: Text('Listado de negocios'),
      ),

      body: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1.0,
                ),
                 borderRadius: BorderRadius.circular(4.0),
              ),
              margin: const EdgeInsets.all(30.0),
              child: TextField(
                onSubmitted: (idbusquedainterno){
                  //print("presione enter o search en el celular");
                  getNegociosConParametro(idbusqueda);
                } ,
                onChanged: (idbusquedainterno){
                  setState(() {
                    idbusqueda=idbusquedainterno;
                  });
                },
                autofocus: false,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    hintText: "ingresa el id a buscar",

                    suffixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                ),
              ),

            ),
           /* Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    onSurface: Colors.grey,
                  ),

                  onPressed:  () {
                    print('Pressed');
                    },
                  child: Text('Buscar Tienda'),
                )
            ),*/

            Container(
                   // margin: const EdgeInsets.only(top: 10.0),
                    child:Divider(),
                ),

            Container(
              margin: const EdgeInsets.all(30.0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: datos_negocios.length,
                itemBuilder: (BuildContext context, i){
                  print('item builder ');
                  return ListTile(
                    title: Text('Negocio '+i.toString()+' - '+datos_negocios[i]['Nombre'].toString()),
                  );
                },
              ),
            ),
          ],

      ),
    );

  }
}
/*
class boton extends StatefulWidget {

  @override
  _botonState createState() => _botonState();
}

class _botonState extends State<boton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(onPressed: (){
          var idbusqueda;
          print(idbusqueda.text);
          //Navigator.push(context, MaterialPageRoute(builder: (context)=> consultaNegocios(idbusqueda.text)));
        },child:
        Text('Consultar'),
            style: ElevatedButton.styleFrom(
                primary: Colors.cyan)
        ),
    );
  }
}
*/



