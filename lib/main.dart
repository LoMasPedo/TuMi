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
          // principal(),
          imagen(url: "https://github.com/festupinans/equipo2_grupo15/blob/master/lib/Imagenes/Logotipo-1%20-%20copia.png?raw=true"),

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
      padding: EdgeInsets.all(20.0),
      child: Image.network(url),
    );
  }
}
