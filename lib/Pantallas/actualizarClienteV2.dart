//import 'package:firebase_grupo15/loginCliente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipo2_grupo15/Pantallas/bienvenida.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*class datosCliente {

  String cedula = "";
  String nombre = "";
  String apellido = "";
  String correo = "";
  String celular = "";
  String direccion = "";


  datosCliente(cedula, nombre, apellido, correo, celular,direccion) {
    this.nombre = nombre;
    this.apellido = apellido;
    this.correo = correo;
    this.cedula = cedula;
    this.celular = celular;
    this.direccion = direccion;
  }

}*/

class actualizarClienteV2 extends StatelessWidget {
  //var cliente;
  final datosCliente cliente;

  actualizarClienteV2(this.cliente);


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
    String cedula=this.cliente.cedula;
    nombre.text=this.cliente.nombre;
    apellido.text=this.cliente.apellido;
    correo.text=this.cliente.correo;
    direccion.text=this.cliente.direccion;
    celular.text=this.cliente.celular;

    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar Datos: "+ this.cliente.nombre),
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

          Row(
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

                      limpiar();

                      Fluttertoast.showToast(msg: "Datos actualizados correctamente", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);

                    }

                  },
                  child: Text("Actualizar",style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              )
            ],

          ),


          Text("Eliminar",style: TextStyle(color: Colors.white, fontSize: 25)),
        ],
      ),
    );

  }
}


/*
class actualizarClienteV2 extends StatelessWidget {
  final datosCliente cliente;
  const actualizarClienteV2({required this.cliente});

  @override
  _actualizarClienteState createState() => _actualizarClienteState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _actualizarClienteState extends State<actualizarClienteV2> {

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
    String cedula=widget.cliente.cedula;
    nombre.text=widget.cliente.nombre;
    apellido.text=widget.cliente.apellido;
    correo.text=widget.cliente.correo;
    direccion.text=widget.cliente.direccion;
    celular.text=widget.cliente.celular;

    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar Datos: "+ widget.cliente.nombre),
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

          Row(
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

                      limpiar();

                      Fluttertoast.showToast(msg: "Datos actualizados correctamente", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);

                    }

                  },
                  child: Text("Actualizar",style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              )
            ],

          ),


          Text("Eliminar",style: TextStyle(color: Colors.white, fontSize: 25)),
        ],
      ),
    );

  }
}*/