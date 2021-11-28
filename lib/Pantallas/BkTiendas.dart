import 'package:equipo2_grupo15/Pantallas/negocios.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'productos.dart';
import 'bienvenida.dart';



class BkTiendas extends StatelessWidget {
  final tiendaOnTAP tienda;
  const BkTiendas({required this.tienda});



  /*void initState() {
    super.initState();
    getCriterio();
  }

  void getCriterio() async {
    CollectionReference datos = FirebaseFirestore.instance.collection('Negocios');
    QuerySnapshot negocio = await datos.where('Id', isEqualTo: widget.id).get();
    if (negocio.docs.length != 0) {
      for (var per in negocio.docs) {
        print(per.data());
        setState(() {
          datos_negocios.add(per);
        });
      }
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build








   /* return Scaffold(
    body: ListView(children: [
    Container(
    margin: const EdgeInsets.all(50.0),
    child:ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: datos_negocios.length,
      itemBuilder: (BuildContext context, i) {*/

        var img =
            "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/icono-tienda.jpg";

        var urlimage =
            'https://source.unsplash.com/random/800x600?market';

        // ESTO FUE NECESARIO YA QUE NO TODOS LOS REGISTROS TRAEN LOGO, DEBERIAN TRAER LOGO O UNA IMAGEN POR DFEFECTO PARA EVITAR ESTO
        if (tienda.Logo != null &&
            tienda.Logo != "") {
          img = tienda.Logo;
        }

        if (tienda.Foto != null &&
            tienda.Foto != "") {
          urlimage = tienda.Foto;
        }

        var cardImage = NetworkImage(urlimage);

        return  Scaffold(
                  body: Stack(
                      children: [
                        new Positioned(

                            height: MediaQuery.of(context).size.width,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: new BoxDecoration(
                                    gradient: new LinearGradient(
                                        colors: [Color(0xFF61D5D4), Color(0xFFFF6961)])),

                                child: Column(
                                    children: [
                                      Container(
                                              margin: new EdgeInsets.only(top: 20),
                                              child: Row(children: [
                                                Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: FloatingActionButton(
                                                        onPressed: (){
                                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(nombre: 'Tú Mí', cedula: '', apellido: '',)));
                                                        },
                                                      child: Icon(Icons.arrow_back_ios_new),
                                                      elevation: 50.0,
                                                      backgroundColor: Color(0xff2a2a2a),
                                                    )),
                                                Text(
                                                  ""+tienda.Nombre,
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ])),
                                      Container(
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(50, 5, 50, 0),
                                              child: Center(
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(30),
                                                    child: Image.network( tienda.Foto)),
                                                      //fit: BoxFit.cover,
                                                    ),
                                                  ))
                                    ]))),
                        new Positioned(
                            bottom: 10.0,
                            child: new Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              margin: new EdgeInsets.only(right: 20,left: 20) ,
                              height: 450.0,
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.6),
                                      spreadRadius: 15,blurRadius: 15,offset: Offset(0,-5),)
                                  ]

                              ),
                              child: Column(
                                  children:[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                  children:[Padding(
                                                    padding: EdgeInsets.all(20),
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(tienda.Logo),
                                                      radius: 50,
                                                    ),
                                                  )]

                                              ),
                                              Column(
                                                children: [
                                                  Text("Celular: " + tienda.Celular,
                                                      style: const TextStyle(
                                                          fontSize: 15, fontWeight: FontWeight.bold)),

                                                  Text("Telefono: " + tienda.Telefono,
                                                      style: const TextStyle(
                                                          fontSize: 15, fontWeight: FontWeight.bold)),
                                                  Text("Dirección: " + tienda.Direccion,
                                                      style: const TextStyle(
                                                          fontSize: 15, fontWeight: FontWeight.bold)),
                                                  Text("Tipo: " + tienda.Tipo,
                                                      style: const TextStyle(
                                                          fontSize: 15, fontWeight: FontWeight.bold)),
                                                  Container(
                                                      margin: new EdgeInsets.only(top: 5)
                                                      ,child:ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          primary: Color(0xFFFF6961),
                                                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                          textStyle: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.bold)),
                                                      onPressed:(){
                                                        launch(tienda.Pagina);
                                                      },
                                                      child: Text("Mi pagina web"))),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )

                                  ]
                              ),
                            )),

                      ]),
                  floatingActionButton: FloatingActionButton.extended(
                      backgroundColor: Color(0xff2a2a2a) ,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => productos()));
                      },
                      label: Text("Comprar"),
                      icon: Icon(Icons.shopping_cart) // This trailing comma makes auto-formatting nicer for build methods.
                  )

          );
      }
    //),
    //),
    //]));;
  }
//}


