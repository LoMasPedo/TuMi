import 'package:equipo2_grupo15/Pantallas/login_cliente.dart';
import 'package:equipo2_grupo15/Pantallas/login_tendero.dart';
import 'package:equipo2_grupo15/Pantallas/negocios.dart';
import 'package:equipo2_grupo15/Pantallas/productos.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';
import 'actualizar_cliente_v2.dart';
import 'package:equipo2_grupo15/global.dart' as global;



class Home extends StatefulWidget {
  final String nombre;
  final String cedula;
  final String apellido;
  const Home( {required this.nombre, required this.cedula, required this.apellido});



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final nombre= TextEditingController();
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.nombre+" "+widget.apellido),
          //Text(widget.nombre+" "+widget.apellido),
          centerTitle: true,
          // leading: IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: (){},
          // ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(context: context, delegate: dataSearch());
              },
            ),
          ],
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

          bottom: TabBar(
            indicatorColor: Colors.limeAccent,
            indicatorWeight: 5,
            tabs: [
              Tab(icon: Icon(Icons.store), text: "Negocios"),
              //Tab(icon: Icon(Icons.star), text: "Feed"),
              Tab(icon: Icon(Icons.shopping_basket), text: "Productos"),
              //Tab(icon: Icon(Icons.settings), text: "settings"),
            ],
          ),

          elevation: 20,
          titleSpacing: 4,
        ),
        drawer: menu(),
        body: TabBarView(
          children: [
            // ListView(
            //   children: [
            //     Container(
            //         child:
            //         imagen(url: "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/TuMI.png")
            //     ),
            //     Container(
            //         padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0,20.0),
            //         child:
            //         const Text('Equipo2_Grupo4',
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //                 color: Colors.cyan,
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.bold,
            //                 fontFamily: 'RobotoR')
            //         )
            //     ),
            //     Container(
            //       padding: EdgeInsets.only(top: 8.0, left: 40.0, right: 40.0),
            //       child:
            //       next1(),
            //     ),
            //     Container(
            //       padding: EdgeInsets.only(top: 8.0, left: 40.0, right: 40.0),
            //       child:
            //       next2(),
            //     )
            //   ],
            // ),

            //buildPage("Profile Page"),
            //actualizarClienteV2(cliente),
            negocios(cedula: widget.cedula,),
            productos(cedula: widget.cedula,),


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

class dataSearch extends SearchDelegate<String>{

  final options = [
    "Madelena 1",
    "Madelena 2",
    "Madelena 3",
    "Madelena 4",
    "Madelena 5",
    "Madelena 6",
    "Madelena 7",
    "Madelena 8",
    "Madelena 9",
    "Madelena 10",
    "Madelena 11",
    "Madelena 12",
    "Tiendas",
    "Negocios",
    "Log In",
    "Compras",
    "Domicilios",
    "Categorias",
  ];

  final mainOptions = [
    "Tiendas",
    "Negocios",
    "Log In",
    "Compras",
    "Domicilios",
    "Categorias",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // acciones para el appbar
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    })];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, "_");
      },
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searchs for something
    final listaPredeterminada = query.isEmpty?mainOptions: options.where((p)=>p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context,index)=>ListTile(
        leading: Icon(Icons.build),
        title: RichText(
          text: TextSpan(
              text: listaPredeterminada[index].substring(0,query.length),
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                    text: listaPredeterminada[index].substring(query.length),
                    style: TextStyle(
                        color: Colors.grey
                    )
                )
              ]
          ),
        ),
      ),
      itemCount: listaPredeterminada.length,
    );
    throw UnimplementedError();
  }
}

