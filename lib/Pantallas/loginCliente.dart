// ignore: file_names
import 'package:flutter/material.dart';
//import 'package:equipo2_grupo15/Pantallas/negocios.dart';
import 'package:equipo2_grupo15/Pantallas/seleccionCliente.dart';
import 'package:equipo2_grupo15/Pantallas/registro_cliente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:equipo2_grupo15/Pantallas/actualizarClienteV2.dart';

import 'bienvenida.dart';

class loginClientes extends StatefulWidget {
  const loginClientes({Key? key}) : super(key: key);

  @override
  _loginClientesState createState() => _loginClientesState();
}

class _loginClientesState extends State<loginClientes> {
  final cedula = TextEditingController();
  final contrasena = TextEditingController();
  CollectionReference cliente = FirebaseFirestore.instance.collection("Clientes");

  @override
  //String UsuarioC = "";
  //String PasswordC = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[300] ,
        title: Text("Login del Cliente"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: cedula,
/*              onChanged: (usuarioc) {
                setState(() {
                  UsuarioC = usuarioc;
                });
                print(UsuarioC);
              },*/
              autofocus: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  prefixIcon:
                  Icon(Icons.account_circle_rounded, color: Colors.cyan[300]),
                  border: OutlineInputBorder(),
                  hintText: "Ingrese su cedula"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: contrasena,
/*              onChanged: (passwordc) {
                setState(() {
                  PasswordC = passwordc;
                });
                print(PasswordC);
              },*/
              obscureText: true,
              autofocus: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password, color: Colors.cyan[300]),
                border: OutlineInputBorder(),
                labelText: 'ContraseÃ±a',
              ),
            ),
          ),
          Container(
            //child: login(),
              child: ElevatedButton(
                  onPressed: () async {
                    QuerySnapshot ingreso = await cliente
                    //.where(FieldPath.documentId, isEqualTo: cedula.text)
                        .where("cedula", isEqualTo: cedula.text)
                        .where("contrasena", isEqualTo: contrasena.text)
                        .get();
                    List listaCliente = [];
                    if (ingreso.docs.length > 0)
                    {
                      for (var cli in ingreso.docs)
                      {
                        listaCliente.add(cli.data());
                      }
                      datosCliente dCli = datosCliente(
                          cedula.text, listaCliente[0]['nombre'],
                          listaCliente[0]['apellido'], listaCliente[0]['correo'],
                          listaCliente[0]['celular'], listaCliente[0]['direccion'], listaCliente[0]['contrasena']);
                      print(dCli.nombre);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(nombre: listaCliente[0]['nombre'], cedula: cedula.text, apellido: listaCliente[0]['apellido']), ));
                      Fluttertoast.showToast(msg: "Cargando Datos",
                          fontSize: 20,
                          backgroundColor: Colors.red,
                          textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER);
                    }
                    else
                    {
                      Fluttertoast.showToast(msg: "Datos Incorrectos",
                          fontSize: 20,
                          backgroundColor: Colors.red,
                          textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text('Login'), Icon(Icons.arrow_forward_sharp) ],
                  ))
          ),
          Container(
            child: register(),
          ),
        ],
      ),
    );
  }
}

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>registroCliente()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Register'),
                Icon(Icons.arrow_forward_sharp)
              ],
            )));
  }
}

class datosCliente
{
  String cedula = "";
  String nombre = "";
  String apellido = "";
  String correo = "";
  String celular = "";
  String contrasena = "";
  String direccion = "";

  datosCliente(cedula, nombre, apellido, correo, celular, direccion, contrasena)
  {
    this.nombre = nombre;
    this.apellido = apellido;
    this.correo = correo;
    this.cedula = cedula;
    this.celular = celular;
    this.contrasena = contrasena;
    this.direccion = direccion;
  }
}