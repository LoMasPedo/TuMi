import 'package:equipo2_grupo15/Pantallas/loginCliente.dart';
import 'package:equipo2_grupo15/Pantallas/loginTendero.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'actualizarClienteV2.dart';

class datosCliente {

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

}

class bienvenida extends StatelessWidget {
  const bienvenida({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mí TU',
      theme: ThemeData(
          fontFamily: 'Roboto'
      ),
      home: PaginaBienvenida(),
    );
  }
}

class PaginaBienvenida extends StatefulWidget {

  @override
  _PaginaBienvenidaState createState() => _PaginaBienvenidaState();
}

class _PaginaBienvenidaState extends State<PaginaBienvenida> {

  /*en el punto donde se consulte el usuario se crea este objeto*/
  final datosCliente cliente = datosCliente("80265922","Mauro","Castelblanco Torres","mao@gmail.com","3125495132","carrera 81b # 2b -93");

  late PageController _pageController;
  int _selectedPage = 0;
  List<Widget> pages = [
  ];

  void onItemTapped (int index){
    setState(() {
      _selectedPage = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState(){
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("TÚ MÍ"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){},
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors:[Colors.blue,Colors.pink],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                )
            ),
          ),

          bottom: TabBar(
            indicatorColor: Colors.limeAccent,
            indicatorWeight: 5,
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.star), text: "Feed"),
              Tab(icon: Icon(Icons.face), text: "Profile"),
              Tab(icon: Icon(Icons.settings), text: "settings"),
            ],
          ),

          elevation: 20,
          titleSpacing: 4,
        ),

        body: TabBarView(
          children: [
            ListView(
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
                  padding: EdgeInsets.only(top: 8.0, left: 40.0, right: 40.0),
                  child:
                  next1(),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8.0, left: 40.0, right: 40.0),
                  child:
                  next2(),
                )
              ],
            ),
            buildPage("Feed Page 1"),
            //buildPage("Profile Page"),
            actualizarClienteV2(cliente),
            buildPage("Settings Page"),
          ],
        ),
      ),
      // appBar: AppBar(
      //   title: Text("Mí Tú"),
      // ),


    );
  }
}

Widget buildPage(String text)=>Center(
  child: Text(
    text,
    style:  TextStyle(fontSize: 28),
  ),
);


class next1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>loginClientes()));
        }, child:
        Text('Login Cliente'),
            style: ElevatedButton.styleFrom(
                primary: Colors.pink)
        )
    );
  }
}
class next2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>loginTendero()));
        },
            child: Text('Login Veci'),
            style: ElevatedButton.styleFrom(
                primary: Colors.pink)
        )
    );
  }
}
class imagen extends StatelessWidget {
  final String url;
  const imagen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0,right: 20.0),
      child: Image.network(url,scale:2),
    );
  }
}


