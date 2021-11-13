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
  String idbusqueda="";
  void initState(){
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    CollectionReference datos= FirebaseFirestore.instance.collection('Negocios'); //Conecta a la conexion
    QuerySnapshot negocios= await datos.get(); //Traer todas los ngocios
    if(negocios.docs.length>0){
      print('Trae datos getNegocios');

      for(var doc in negocios.docs){
       // print(doc.data());
        setState(() {
        datos_negocios.add(doc.data());
        });
        print('agregar datos negocio');

      }
      /*setState(() {
        datos_negocios =datos_negocios
      });*/
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

      body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(30.0),
              child: TextField(
                onChanged: (idbusquedainterno){
                  setState(() {
                    idbusqueda=idbusquedainterno;
                  });
                  print(idbusqueda);
                },
                autofocus: false,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    hintText: "ingresa el id a buscar"
                ),
              ),

            ),
            Container(
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
            ),
            Container(
                    margin: const EdgeInsets.only(top: 10.0),
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




