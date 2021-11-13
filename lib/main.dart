import 'package:equipo2_grupo15/Pantallas/bienvenida.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: PaginaBienvenida(),
    );
  }
}

class PaginaBienvenida extends StatefulWidget {

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
      
      body: Column(
        children: [
          Container(

            child:
              // principal(),
              imagen(url: "https://github.com/festupinans/equipo2_grupo15/blob/master/lib/Imagenes/TuMI.png?raw=true")
          ),


          Container(
              padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0,20.0),

            child:
              const Text('Equipo2_Grupo4', style: TextStyle(
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
      padding: EdgeInsets.fromLTRB(20.0, 200.0, 20.0,20.0),
      child: Image.network(url),
    );
  }
}

class next extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(

      child:
        ElevatedButton(

            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const bienvedina()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Siguiente'),
                Icon(Icons.arrow_forward_sharp)
              ],
            )
        )
    );

  }
}
