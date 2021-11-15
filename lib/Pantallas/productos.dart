import 'package:equipo2_grupo15/Pantallas/loginCliente.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipo2_grupo15/Pantallas/consultaProductos.dart';
import 'dart:convert';

class productos extends StatefulWidget {

  TextEditingController idbusqueda=TextEditingController();
  @override

  State<productos> createState() => _productosState();
}

class _productosState extends State<productos> {

  List datos_productos=[];
  String idbusqueda="";

  void initState(){
    super.initState();
    getProductos();
  }

  void getProductos() async {
    CollectionReference datos= FirebaseFirestore.instance.collection('Productos'); //Conecta a la conexion
    QuerySnapshot productos= await datos.get(); //Traer todas los ngocios
    if(productos.docs.length>0){
      //print('Trae datos getNegocios');

      for(var doc in productos.docs){
        // print("---------");
        // print(doc.id);
        setState(() {
          datos_productos.add(doc.data());
        });
        // print('agregar datos negocio');

      }
    }else{
      print('ha fallado....');
    }
  }

  void getProductosConParametro(String palabra) async {
    setState(() {
      datos_productos=[];
    });
    CollectionReference datos= FirebaseFirestore.instance.collection('Productos');
    QuerySnapshot productos= await datos.get();
    //En el momento no encontre en las clases como hacer una busqeuda de texto en firebase realice un filtro.
    if(productos.docs.length>0){
      for(var doc in productos.docs){
        var data =  doc.data();
        if(doc.get("Producto").toLowerCase().indexOf(palabra.toLowerCase())!=-1){
          //print("si ahy concidencia");
          setState(() {
            datos_productos.add(doc.data());
          });
        }


      }
    }else{
      print('no se encontraron productos....');
    }

  }

  void getProductosCategoria(String palabra) async {
    setState(() {
      datos_productos=[];
    });
    CollectionReference datos= FirebaseFirestore.instance.collection('Productos');
    QuerySnapshot productos= await datos.get();
    //En el momento no encontre en las clases como hacer una busqeuda de texto en firebase realice un filtro.
    if(productos.docs.length>0){
      for(var doc in productos.docs){
        var data =  doc.data();
        if(doc.get("Categoría").toLowerCase().indexOf(palabra.toLowerCase())!=-1){
          //print("si ahy concidencia");
          setState(() {
            datos_productos.add(doc.data());

            // for(var doc in datos_productos){
            //   print(doc.data());
            //
            // };
          });
        }
      }
    }else{
      print('no se encontraron negocios....');
    }
  }

  var _listacategoria = ['Cuidado Hogar','lacteos y huevos','Bebidas','Cervezas','Abarrotes','Bebidas'];
  String _vista = 'categoria';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('Listado de Productos'),
      ),

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
                //print("presione enter o search en el celular");
                getProductosConParametro(idbusqueda);
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
                hintText: "Ingresa el producto ",

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
                  getProductosCategoria(_vista);
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
              itemCount: datos_productos.length,
              itemBuilder: (BuildContext context, i){
                var img=  "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/icono-tienda.jpg";
                if(datos_productos[i]['Logo'] !=null){
                  img = datos_productos[i]['Logo'];
                }

                return Card(
                    child: ListTile(
                        title: Text(datos_productos[i]['Producto'].toString()),
                        subtitle: Text(datos_productos[i]['Precio Unitario'].toString()),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                img)),
                        trailing: Icon(Icons.add_business_outlined),
                        onTap: () => {
                          print(datos_productos[i]['Producto'].toString()),
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> consultaNegocios(datos_negocios[i])))
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> consultaProductos(datos_productos[i]['Id'].toString())))
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