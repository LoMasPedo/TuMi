import 'package:flutter/material.dart';
import 'package:equipo2_grupo15/Pantallas/loginUsuarios.dart';
import 'package:equipo2_grupo15/Pantallas/loginTendero.dart';

class bienvedina extends StatefulWidget {
  const bienvedina({Key? key}) : super(key: key);

  @override
  _bienvedinaState createState() => _bienvedinaState();
}

class _bienvedinaState extends State<bienvedina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccion'),
      ),
      body: Column(
        children: [
          Container(
            child:
            next1(),
          ),
          Container(
            child:
            next2(),
          ),
        ],
      ),
    );
  }
}


class next1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>loginUsuarios()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Login Cliente'),
                Icon(Icons.arrow_forward_sharp)
              ],
            )
        )
    );

  }
}

class next2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>loginTendero()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Login Veci'),
                Icon(Icons.arrow_forward_sharp)
              ],
            )
        )
    );

  }
}