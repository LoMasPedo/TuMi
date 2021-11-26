import 'package:equipo2_grupo15/Pantallas/actualizarClienteV2.dart';
import 'package:equipo2_grupo15/Pantallas/bienvenida.dart';
import 'package:equipo2_grupo15/Pantallas/loginCliente.dart';
import 'package:equipo2_grupo15/Pantallas/loginTendero.dart';
import 'package:equipo2_grupo15/Pantallas/registro_cliente.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mí Tú',
      theme: ThemeData(
          fontFamily: 'Roboto'
      ),
      home: PaginaBienvenida(

      ),
    );
  }
}

class PaginaBienvenida extends StatefulWidget {
  final datosCliente2 cliente = datosCliente2("80265922","Mauro","Castelblanco Torres","mao@gmail.com","3125495132","carrera 81b # 2b -93");

  @override
  _PaginaBienvenidaState createState() => _PaginaBienvenidaState();
}

class _PaginaBienvenidaState extends State<PaginaBienvenida> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //   title: Text("Mí Tú"),
      // ),

      body: ListView(

        children: [
          Container(

              child:
              imagen(url: "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/TuMI.png")
          ),


          Container(
              padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0,20.0),

              child:
              const Text('Equipo2_Grupo4',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RobotoR')
              )
          ),
          Container(
            child:
            next(),
          ),

        ],
      ),
    );
  }
}

class imagen extends StatelessWidget {
  final String url;
  const imagen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 100.0, 30.0,30.0),
      child: Image.network(url,scale:2),
    );
  }
}

class next extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(

        child:
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(nombre: 'Tú Mí', cedula: '', apellido: '',)));
        },child:
        Text('Continuar'),
            style: ElevatedButton.styleFrom(
                primary: Colors.pink)
        )
    );
  }
}

class menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(gradient:
              LinearGradient(colors: [
                Color(0xFF61D5D4),
                Color(0xFFFF6961)
              ],
              begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )

              ),
              child: Image.network('https://github.com/festupinans/equipo2_grupo15/blob/master/lib/Imagenes/TuMi2.png?raw=true' )
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.face_retouching_natural , size: 30, color:  Color(0xFFFF6961)),
                title: Text('Login Cliente'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>loginClientes()));
                },
              ),
              ListTile(
                leading: Icon(Icons.login , size: 30, color:  Color(0xFFFF6961)),
                title: Text('Login Tendero'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>loginTendero()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add , size: 30, color:  Color(0xFFFF6961)),
                enabled: true,
                title: Text('Registrar Clientes'),

                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registroCliente()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add , size: 30, color:  Color(0xFFFF6961)),
                enabled: true,
                title: Text('Registrar Terndero'),
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>registroTe));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add , size: 30, color:  Color(0xFFFF6961)),
                enabled: true,
                title: Text('Actualizar Cliente'),
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>actualizarClienteV2(cliente)));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class datosCliente2 {

  String cedula = "";
  String nombre = "";
  String apellido = "";
  String correo = "";
  String celular = "";
  String direccion = "";


  datosCliente2(cedula, nombre, apellido, correo, celular,direccion) {
    this.nombre = nombre;
    this.apellido = apellido;
    this.correo = correo;
    this.cedula = cedula;
    this.celular = celular;
    this.direccion = direccion;
  }

}