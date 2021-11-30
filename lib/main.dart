import 'package:equipo2_grupo15/Pantallas/bk_tiendas.dart';
import 'package:equipo2_grupo15/Pantallas/actualizar_cliente_v2.dart';
import 'package:equipo2_grupo15/Pantallas/bienvenida.dart';
import 'package:equipo2_grupo15/Pantallas/login_cliente.dart';
import 'package:equipo2_grupo15/Pantallas/login_tendero.dart';
import 'package:equipo2_grupo15/Pantallas/modulo_pedido.dart';
import 'package:equipo2_grupo15/Pantallas/registro_cliente.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipo2_grupo15/global.dart' as global;
import 'package:fluttertoast/fluttertoast.dart';

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
  //final datosCliente2 cliente = datosCliente2("80265922","Mauro","Castelblanco Torres","mao@gmail.com","3125495132","carrera 81b # 2b -93");

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

      body: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: const FractionalOffset(1.0, 0.1),
                end: const FractionalOffset(1.0, 0.9),
                colors: [Color(0xFF61D5D4), Color(0xFFFF6961)])),
        child: ListView(

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
      ),)
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
        margin: EdgeInsets.all(100),
        child:
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(nombre: 'Tú Mí', cedula: '', apellido: '',)));
        },child:
        Text('Continuar'),
            style: ElevatedButton.styleFrom(
                primary: Color(0xff2a2a2a))
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
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                color:  Colors.grey[100],
                child: ListTile(
                  leading: Icon(Icons.face_retouching_natural , size: 30, color:  Color(0xFFFF6961)),
                  title: Text('Login Cliente'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>loginClientes()));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                color:  Colors.cyan[50],
                child: ListTile(
                  leading: Icon(Icons.login , size: 30, color:  Color(0xFFFF6961)),
                  title: Text('Login Tendero'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>loginTendero()));
                  },
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 2),
              //   padding: const EdgeInsets.all(10),
              //   width: double.infinity,
              //   color:  Colors.grey[100],
              //   child: ListTile(
              //     leading: Icon(Icons.person_add , size: 30, color:  Color(0xFFFF6961)),
              //     enabled: true,
              //     title: Text('Registrar Clientes'),
              //
              //     onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (context)=>registroCliente()));
              //     },
              //   ),
              // ),
              // Container(
              //   margin: const EdgeInsets.only(top: 2),
              //   padding: const EdgeInsets.all(10),
              //   width: double.infinity,
              //   color:  Colors.cyan[50],
              //   child: ListTile(
              //     leading: Icon(Icons.person_add , size: 30, color:  Color(0xFFFF6961)),
              //     enabled: true,
              //     title: Text('Registrar Tendero'),
              //     onTap: (){
              //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>registroTe));
              //     },
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                color:  Colors.grey[100],
                child: ListTile(
                  leading: Icon(Icons.person_add , size: 30, color:  Color(0xFFFF6961)),
                  enabled: true,
                  title: Text('Perfil \nActualizar datos del Cliente'),
                  onTap: (){
                    if(global.clienteLogeado != null)
                      {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>BkTiendas(tienda)));
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>actualizarClienteV2()));
                      }
                    else
                      {
                        Fluttertoast.showToast(msg: "Debe primero hacer login de cliente",
                            fontSize: 20,
                            textColor: Colors.black,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER);
                      }
                  },
                ),
              ),




              // Container(
              //   margin: const EdgeInsets.only(top: 2),
              //   padding: const EdgeInsets.all(10),
              //   width: double.infinity,
              //   color:  Colors.grey[100],
              //   child: ListTile(
              //     leading: Icon(Icons.account_box, size: 30, color:  Color(0xFFFF6961)),
              //     enabled: true,
              //     title: Text('Registrar Pedido'),
              //     onTap: (){
              //        Navigator.push(context, MaterialPageRoute(builder: (context)=>moduloPedido()));
              //       }
              //
              //   ),
              // ),




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