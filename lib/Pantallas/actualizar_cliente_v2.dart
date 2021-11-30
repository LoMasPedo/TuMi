//import 'package:firebase_grupo15/login_cliente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipo2_grupo15/Pantallas/bienvenida.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:equipo2_grupo15/global.dart' as global;

import '../main.dart';
import 'login_cliente.dart';



class actualizarClienteV2 extends StatelessWidget {
  //var cliente;


  void limpiar(){
    correo.text=""; nombre.text=""; apellido.text="";  direccion.text=""; celular.text="";
  }
  CollectionReference clientes = FirebaseFirestore.instance.collection('Clientes');

  final nombre=TextEditingController();
  final apellido=TextEditingController();
  final correo=TextEditingController();
  final direccion=TextEditingController();
  final celular=TextEditingController();



  @override
  Widget build(BuildContext context) {
    String cedula=global.clienteLogeado!.cedula;
    String contrasena = global.clienteLogeado!.contrasena;
    nombre.text=global.clienteLogeado!.nombre;
    apellido.text=global.clienteLogeado!.apellido;
    correo.text=global.clienteLogeado!.correo;
    direccion.text=global.clienteLogeado!.direccion;
    celular.text=global.clienteLogeado!.celular;

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
        title: Text("Actualizar Datos: "+ global.clienteLogeado!.nombre),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: nombre,
              decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.assignment_ind_rounded,
                      size: 50, color: Color(0xFFFF6961)),
                  hintText: "Digite su nombre",
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          ),

          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Color(0xFFFF6961)),
              controller: apellido,
              decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.assignment_ind_outlined,
                      size: 50, color: Color(0xFFFF6961)),
                  hintText: "Digite su apellido",
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          ),

          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: correo,
              decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.attach_email_rounded,
                      size: 50, color: Color(0xFFFF6961)),
                  hintText: "Digite su e-mail",
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          ),

          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: direccion,
              decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.home_sharp,
                      size: 50, color: Color(0xFFFF6961)),
                  hintText: "Digite su direccion",
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          ),


          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: celular,
              decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.phone,
                      size: 50, color: Color(0xFFFF6961)),
                  hintText: "Digite su celular",
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: ElevatedButton(
                  onPressed:(){
                    if(correo.text.isEmpty || nombre.text.isEmpty || apellido.text.isEmpty || direccion.text.isEmpty ||celular.text.isEmpty ){
                      Fluttertoast.showToast(msg: "Hacen  falta  campos  por ingresar", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                    }else{
                      clientes.doc(cedula).update({
                        "correo": correo.text,
                        "nombre": nombre.text,
                        "apellido": apellido.text,
                        "direccion": direccion.text,
                        "celular": celular.text

                      });

                      global.clienteLogeado =  global.datosCliente(
                         cedula, nombre.text,
                         apellido.text, correo.text,
                          celular.text, direccion.text,contrasena);

                      limpiar();

                      Fluttertoast.showToast(msg: "Datos actualizados correctamente", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);

                    }

                  },
                  child: Text("Actualizar",style: TextStyle(color: Colors.white, fontSize: 25)),style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent)
                ),
              )
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: ElevatedButton(

                  onPressed: (){
                    if(cedula.isEmpty){
                      Fluttertoast.showToast(msg: "Campos Vacios", fontSize: 15, backgroundColor: Colors.black, textColor: Colors.white,toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                    }else
                    {
                      clientes.doc(cedula).delete();
                      limpiar();
                      Fluttertoast.showToast(msg: "Cliente Eliminado Exitosamente", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>loginClientes()));
                    }
                  },
                  child: Text("Eliminar  ",style: TextStyle(color: Colors.white, fontSize: 25)),style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent)



              ),
            )

          ],
        )

          //Text("Eliminar",style: TextStyle(color: Colors.white, fontSize: 25)),
        ],
      ),
    );

  }
}
