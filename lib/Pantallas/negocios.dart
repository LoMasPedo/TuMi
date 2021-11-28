
import 'package:equipo2_grupo15/Pantallas/loginCliente.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipo2_grupo15/Pantallas/consultaNegocios.dart';
import 'dart:convert';
import 'BkTiendas.dart';



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
      for(var doc in negocios.docs){
      //var data =  doc.data();
      var productosResultado = [];
          try {
            var productos = doc["Productos"];

            if (productos.length != 0) {
              for (var i = 0; i < productos.length; i++) {
                var productoInfo = productos[i];
                var productoCompleto = await productoInfo["Producto"].get();
                productosResultado.add({"precio":productoInfo["Precio"],
                                         "Unidades":productoInfo["Unidades"],
                                          "Producto": productoCompleto.data()
                });
              }
            }
          }catch(error){
            print(error);
            //es por que no existen productos en el negocio
           print(doc["Nombre"] +" no tiene productos, agregar en la base de datos");

          }

        tiendaOnTAP tienda = tiendaOnTAP(
            doc['Nombre'],
            doc['Celular'],
            doc['Tipo'],
            doc['Categoria'],
            doc['Foto'],
            doc['Dirección'],
            doc['Id'],
            doc['Geolocalización'],
            doc['Teléfono'],
            doc['Pagina Web'],
            doc['Logo'],
            productosResultado,
          );

          setState(() {
            datos_negocios.add(tienda);
          });

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

          var productosResultado = [];
          try {
            var productos = doc["Productos"];

            if (productos.length != 0) {
              for (var i = 0; i < productos.length; i++) {
                var productoInfo = productos[i];
                var productoCompleto = await productoInfo["Producto"].get();
                productosResultado.add({"precio":productoInfo["Precio"],
                  "Unidades":productoInfo["Unidades"],
                  "Producto11": productoCompleto.data()
                });
              }
            }
          }catch(error){
            print(error);
            //es por que no existen productos en el negocio
            print(doc["Nombre"] +" no tiene productos, agregar en la base de datos");

          }



          tiendaOnTAP tienda = tiendaOnTAP(
            doc['Nombre'],
            doc['Celular'],
            doc['Tipo'],
            doc['Categoria'],
            doc['Foto'],
            doc['Dirección'],
            doc['Id'],
            doc['Geolocalización'],
            doc['Teléfono'],
            doc['Pagina Web'],
            doc['Logo'],
            productosResultado,
          );


          setState(() {
            datos_negocios.add(tienda);//doc.data());
          });
        }


      }
    }else{
      print('no se encontraron negocios....');
    }

  }

  void getNegociosCategoria(String palabra) async {
    setState(() {
      datos_negocios=[];
    });
    CollectionReference datos= FirebaseFirestore.instance.collection('Negocios');
    QuerySnapshot negocios= await datos.get();
    //En el momento no encontre en las clases como hacer una busqeuda de texto en firebase realice un filtro.
    if(negocios.docs.length>0){
      for(var doc in negocios.docs){
        var data =  doc.data();
       if(doc.get("Categoria").toLowerCase().indexOf(palabra.toLowerCase())!=-1){

         var productosResultado = [];
         try {
           var productos = doc["Productos"];

           if (productos.length != 0) {
             for (var i = 0; i < productos.length; i++) {
               var productoInfo = productos[i];
               var productoCompleto = await productoInfo["Producto"].get();
               productosResultado.add({"precio":productoInfo["Precio"],
                 "Unidades":productoInfo["Unidades"],
                 "Producto11": productoCompleto.data()
               });
             }
           }
         }catch(error){
           print(error);
           //es por que no existen productos en el negocio
           print(doc["Nombre"] +" no tiene productos, agregar en la base de datos");

         }


         tiendaOnTAP tienda = tiendaOnTAP(
           doc['Nombre'],
           doc['Celular'],
           doc['Tipo'],
           doc['Categoria'],
           doc['Foto'],
           doc['Dirección'],
           doc['Id'],
           doc['Geolocalización'],
           doc['Teléfono'],
           doc['Pagina Web'],
           doc['Logo'],
           productosResultado,
         );
          setState(() {
            datos_negocios.add(tienda);//doc.data());
          });
        }
      }
    }else{
      print('no se encontraron negocios....');
    }
  }



  var _listacategoria = ['lacteos','cuidado personal','cuidado hogar','cervezas','bebidas','abarrotes'];
  String _vista = 'categoria';

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      body: ListView(
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
                    hintText: "Ingresa el negocio a buscar",
                    suffixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                ),
              ),

            ),

            Container(
              padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0,0.0),
              child: DropdownButton(
                items: _listacategoria.map((String a){
                  return DropdownMenuItem(
                      value: a,
                      child: Text(a));
                }).toList(),
                onChanged: (_value)=>{
                  setState((){
                    String _vista1 = _value.toString();
                    _vista = _vista1;
                    getNegociosCategoria(_vista);
                  })
                },
                hint: Text(_vista),
              ),
            ),

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
                  var img=  "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/icono-tienda.jpg";
                  if(datos_negocios[i].Logo !=null){
                    img = datos_negocios[i].Logo;
                  }

                  return Card(
                      child: ListTile(
                          title: Text(datos_negocios[i].Nombre.toString()),
                          subtitle: Text(datos_negocios[i].Tipo.toString()),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  img)),
                          trailing: Icon(Icons.add_business_outlined),

                          onTap:(){
                            print('Productos');
                            /*print(datos_negocios[i]['Productos']);
                            tiendaOnTAP tiendaSeleccionada = tiendaOnTAP(
                                datos_negocios[i]['Nombre'],
                                datos_negocios[i] ['Celular'],
                                datos_negocios[i] ['Tipo'],
                                datos_negocios[i] ['Categoria'],
                                datos_negocios[i] ['Foto'],
                                datos_negocios[i] ['Dirección'],
                                datos_negocios[i] ['Id'],
                                datos_negocios[i] ['Geolocalización'],
                                datos_negocios[i] ['Teléfono'],
                                datos_negocios[i] ['Pagina Web'],
                                datos_negocios[i] ['Logo'],
                                datos_negocios[i] ['Productos']
                            );*/


                            Navigator.push(context, MaterialPageRoute(builder: (context)=> BkTiendas(tienda: datos_negocios[i])));
                          }
                      )
                  );
                },
              ),
            ),
          ],


      ),
    );

  }
}



class tiendaOnTAP{

  String Nombre="";
  String Celular= "";
  String Tipo="";
  String Categoria="";
  String Foto="";
  String Direccion="";
  String id="";
  String Geolocalizacion="";
  String Telefono="";
  String Pagina="";
  String Logo="";
  var Productos= [];


  tiendaOnTAP(nombre,celular,tipo,categoria,foto,direccion,id,geolocalizacion,telefono,pagina,logo,productos) {
    this.Nombre=nombre;
    this.Celular=celular.toString();
    this.Tipo=tipo;
    this.Categoria=categoria;
    this.Foto=foto;
    this.Direccion=direccion;
    this.id=id;
    this.Geolocalizacion=geolocalizacion;
    this.Telefono=telefono.toString();
    this.Pagina=pagina;
    this.Logo=logo ?? "";
    this.Productos=productos ?? [] ;
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



