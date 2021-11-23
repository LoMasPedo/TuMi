import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:equipo2_grupo15/Pantallas/seleccionCliente.dart';



import '../main.dart';

class registroCliente extends StatefulWidget {
  const registroCliente({Key? key}) : super(key: key);
  @override
  _registroClienteState createState() => _registroClienteState();
}

class _registroClienteState extends State<registroCliente> {
  final correo = TextEditingController();
  final nombre = TextEditingController();
  final apellido = TextEditingController();
  final cedula = TextEditingController();
  final direccion = TextEditingController();
  final celular = TextEditingController();
  final contrasena = TextEditingController();
  final contrasena1 = TextEditingController();
  
  CollectionReference clientes = FirebaseFirestore.instance.collection('Clientes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[300],
        title: Text('Registro Cliente'),
      ),
      body: Center(
        child: ListView(
          children: [
            Expanded(
              child: Image(
                image: NetworkImage(
                    "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/TuMI.png"),
                height: 160,
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
                        size: 50, color: Colors.cyan[300]),
                    hintText: "Digite su e-mail",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: nombre,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.assignment_ind_rounded,
                        size: 50, color: Colors.cyan[300]),
                    hintText: "Digite su nombre",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: apellido,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.assignment_ind_outlined,
                        size: 50, color: Colors.cyan[300]),
                    hintText: "Digite su apellido",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: cedula,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.contact_mail_rounded,
                        size: 50, color: Colors.cyan[300]),
                    hintText: "Digite su cedula",
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
                        size: 50, color: Colors.cyan[300]),
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
                        size: 50, color: Colors.cyan[300]),
                    hintText: "Digite su celular",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: contrasena,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.password,
                        size: 50, color: Colors.cyan[300]),
                    hintText: "Digite su contraseña",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: contrasena1,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.password,
                        size: 50, color: Colors.cyan[300]),
                    hintText: "Digite su contraseña nuevamente",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(100, 5, 100, 10),
              child: ElevatedButton(
                onPressed: () async {
                  if(correo.text.isEmpty || nombre.text.isEmpty || apellido.text.isEmpty || cedula.text.isEmpty || direccion.text.isEmpty ||celular.text.isEmpty ||contrasena.text.isEmpty || contrasena1.text.isEmpty){
                    print("Campos Vacios");
                    Fluttertoast.showToast(msg: "Campos vacios", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                  }
                  else if(contrasena.text != contrasena1.text){
                    print("Las contraseñas no coinciden");
                  }
                  else if(contrasena.text == contrasena1.text){
                    QuerySnapshot existe = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                    if(existe.docs.length>0){
                      print("El cliente ya existe");
                      Fluttertoast.showToast(msg: "El cliente ya existe", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                    }else{
                      print("Las contraseñas si coinciden");
                      clientes.doc(cedula.text).set({
                        "correo" : correo.text,
                        "nombre" : nombre.text,
                        "apellido" : apellido.text,
                        "cedula" : cedula.text,
                        "direccion" : direccion.text,
                        "celular" : celular.text,
                        "contrasena" : contrasena.text
                      });
                      QuerySnapshot inserto = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                      if(inserto.docs.length>0){
                        print("Se registro exitosamente");
                        Fluttertoast.showToast(msg: "Se registro exitosamente", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>seleccionCliente()));
                      }else{
                        print("No se registro exitosamente");
                        Fluttertoast.showToast(msg: "No se registro exitosamente", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                      }

                    }
                  }
                },
                child: Text("Registrar",style: TextStyle(color: Colors.white, fontSize: 20 ),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

