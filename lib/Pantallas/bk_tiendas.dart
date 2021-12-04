// import 'dart:html';

import 'package:equipo2_grupo15/Pantallas/carrito_compra.dart';
import 'package:equipo2_grupo15/Pantallas/negocios.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'productos.dart';
import 'bienvenida.dart';
import '../mapas.dart';

class BkTiendas extends StatelessWidget {
  final tiendaOnTAP tienda;
  final String cedula;
  const BkTiendas({required this.tienda, required this.cedula});

  @override

  Widget build(BuildContext context) {

    // TODO: implement build

    var img =
        "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/icono-tienda.jpg";

    var urlimage = 'https://source.unsplash.com/random/800x600?market';

    // ESTO FUE NECESARIO YA QUE NO TODOS LOS REGISTROS TRAEN LOGO, DEBERIAN TRAER LOGO O UNA IMAGEN POR DFEFECTO PARA EVITAR ESTO
    if (tienda.Logo != null && tienda.Logo != "") {
      img = tienda.Logo;
    }

    if (tienda.Foto != null && tienda.Foto != "") {
      urlimage = tienda.Foto;
    }

    var cardImage = NetworkImage(urlimage);

    return Container(
      decoration: BoxDecoration(
          gradient: new LinearGradient(
              begin: const FractionalOffset(0.4, 0.1),
              end: const FractionalOffset(1.0, 0.9),
              colors: [Color(0xFF61D5D4), Color(0xFFFF6961)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: new ListView(
              children: [
                new Positioned(
                    child: Container(
                        margin: new EdgeInsets.only(bottom: 30),
                        /*decoration: new BoxDecoration(
                              gradient: new LinearGradient(
                                  begin: const FractionalOffset(1.0, 0.1),
                                  end: const FractionalOffset(1.0, 0.9),
                                  colors: [Color(0xFF61D5D4), Color(0xFFFF6961)])),*/
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          Container(
                              child: Row(children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: FloatingActionButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home(
                                                  nombre: 'Tú Mí',
                                                  cedula: '',
                                                  apellido: '',
                                                )));
                                  },
                                  child: Icon(Icons.arrow_back_ios_new),
                                  elevation: 30.0,
                                  backgroundColor: Color(0xFFFF6961),
                                )),
                            Text(
                              "" + tienda.Nombre,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            )
                          ])),
                        ]))),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: new EdgeInsets.only(right: 20, left: 20),
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 10,
                          blurRadius: 15,
                          offset: Offset(0, 10),
                        )
                      ]),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.40,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 0, 0, 0),
                                        child: Center(
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child:
                                                  Image.network(tienda.Foto)),
                                          // fit: BoxFit.cover
                                        ),
                                      )),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.45,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(tienda.Logo),
                                            radius: 30,
                                          ),
                                        ),
                                        Text("Celular: " + tienda.Celular,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        Text("Telefono: " + tienda.Telefono,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        Text("Dirección: " + tienda.Direccion,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        Text("Tipo: " + tienda.Tipo,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        Container(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color(0xFFFF6961),
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                    textStyle: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>mapas()));
                                                 // launch(tienda.);
                                                },
                                                child: Text("Ver Ubicación"))
                                        ),

                                        Container(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color(0xFFFF6961),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 10),
                                                    textStyle: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  launch(tienda.Pagina);
                                                },
                                                child: Text("Mi pagina web"))
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.50,
                                  child: new ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: tienda.Productos.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {

                                      int contt = 0;
                                      var can = TextEditingController();

                                      //return new Text(tienda.Productos[index]["Producto"]["Producto"]);
                                      print(tienda.Productos[index]);

                                      var img =
                                          "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/icono-tienda.jpg";
                                      if (tienda.Productos[index]["Producto"]
                                              ["Logo"] !=
                                          null) {
                                        img = tienda.Productos[index]
                                            ["Producto"]["Logo"];
                                      }

                                      return Card(
                                        child: ListTile(
                                          leading: CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(img)),
                                          title: Text(tienda.Productos[index]
                                              ["Producto"]["Producto"]),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.0, 0.0, 0.0, 10.0),
                                                  child: Text("Stock: " +
                                                      tienda.Productos[index]
                                                          ["Unidades"] +
                                                      "\nPrecio: " +
                                                      tienda.Productos[index]
                                                          ["precio"] +
                                                      "\nCategoria: " +
                                                      tienda.Productos[index]
                                                              ["Producto"]
                                                          ["Categoria"]),
                                                ),
                                              ),
                                              // Row(
                                              //   children: [
                                              //     botones(),
                                              //   ],
                                              // ),
                                              Container(
                                                child: Row(
                                                children: [
                                                  Container(
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            primary: Color(
                                                                0xFFFF6961),

                                                            textStyle: TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                        onPressed: () {
                                                          contt++;
                                                          print(contt.toString());
                                                        },
                                                        child: Icon(Icons.add)),
                                                  ),

                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsets.all(15.0),
                                                      child: Text(contt.toString()),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          primary:
                                                          Color(0xFFFF6961),

                                                          textStyle: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                      onPressed: () {

                                                        contt--;
                                                        if (contt < 0) {
                                                          contt = 0;
                                                        }
                                                        print(contt.toString());
                                                      },
                                                      child: Icon(Icons.remove),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                                                    child: Icon(Icons.add_shopping_cart, size: 40, color: Color(0xFFFF6961)),
                                                  ),

                                                ],
                                              ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            int total = contt * int.parse( tienda.Productos[index]["precio"]);
                                                p = produc(tienda.Productos[index]["Producto"]["Producto"],  tienda.Productos[index]["Producto"]["Categoria"],  tienda.Productos[index]["precio"], contt, total);
                                                print(contt);
                                                print( tienda.Productos[index]["precio"].toString());
                                                print(total);
                                                pedido.add(p);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          Divider(
                            height: 20,
                          )
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Color(0xff2a2a2a),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => carritoCompras(
                            pedido: pedido, cedula: cedula, id: tienda.id)));
              },
              label: Text("Comprar"),
              icon: Icon(Icons
                  .shopping_cart) // This trailing comma makes auto-formatting nicer for build methods.
              )),
    );
  }
}

List<produc> pedido = [];
produc p = produc('', '', '', 0, 0);

class botones extends StatefulWidget {
  const botones({Key? key}) : super(key: key);

  @override
  _botonesState createState() => _botonesState();
}

class _botonesState extends State<botones> {

  int contt = 0;
  var can = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFF6961),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  textStyle:
                      TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              onPressed: () {
                contt++;
              },
              child: Icon(Icons.add)),
        ),
        Container(
          child: TextField(
            controller: can,
            decoration: InputDecoration(hintText: contt.toString()),
          ),
        ),
        Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF6961),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                textStyle:
                    TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            onPressed: () {
              contt--;
              if (contt < 0) {
                contt = 0;
              }
            },
            child: Icon(Icons.remove),
          ),
        ),
      ],
    );
  }
}

class addbotonmas extends StatefulWidget {
  @override
  _addbotonmasState createState() => _addbotonmasState();
}

class _addbotonmasState extends State<addbotonmas> {
  int cont = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFFF6961),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          onPressed: () {
            //   if (pedido['nombre'] == widget.nombre || p.nombre == widget.nombre) {
            //     print('El producto ya ha sido seleccionado');
            //   } else {
            //     cont++;
            //     int total = cont * int.parse(widget.precio);
            //     p = produc(
            //         widget.nombre, widget.categoria, widget.precio, cont,
            //         total);
            //     print(cont);
            //     print(widget.precio.toString());
            //     print(total);
            //     pedido.add(p);
            //
            // }

            // if (cont == 1) {

            // cont = 1;
            // }
            // if (cont > 1) {
            //   pedido.remove(p);
            //   cont = 0;
            // }
          },
          child: Icon(Icons.add)),
    );
  }
}

class produc {
  String nombre = '';
  String descripcion = '';
  String precio = '';
  int cantidad = 0;
  int total = 0;

  produc(nombre, descripcion, precio, cantidad, total) {
    this.nombre = nombre;
    this.descripcion = descripcion;
    this.precio = precio;
    this.cantidad = cantidad;
    this.total = total;
  }
}
