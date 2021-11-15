import 'package:flutter/material.dart';
import 'package:equipo2_grupo15/Pantallas/loginCliente.dart';
import 'package:equipo2_grupo15/Pantallas/loginTendero.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class bienvedina extends StatefulWidget {
  const bienvedina({Key? key}) : super(key: key);

  @override
  _bienvedinaState createState() => _bienvedinaState();
}

class _bienvedinaState extends State<bienvedina> {

  // List datos_nogocios=[];
  //
  // void initState(){
  //   super.initState();
  //  // getNegocios();
  // }
  //
  // void getNegocios() async {
  //   CollectionReference datos= FirebaseFirestore.instance.collection('Negocios'); //Conecta a la conexion
  //   QuerySnapshot negocios= await datos.get(); //Traer todas las personas
  //   if(negocios.docs.length>0){
  //     print('Trae datos');
  //
  //     for(var doc in negocios.docs){
  //       print(doc.data());
  //       datos_nogocios.add(doc.data());
  //
  //     }
  //   }else{
  //     print('ha fallado....');
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            child:
            imagen(url: "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/TuMI.png"),
          ),
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
      padding: EdgeInsets.fromLTRB(30.0, 100.0, 30.0,30.0),
      child: Image.network(url,scale:2),
    );
  }
}