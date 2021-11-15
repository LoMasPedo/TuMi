import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class consultaProductos extends StatefulWidget {
  final String id;
  const consultaProductos(this.id, {Key? key}) : super(key: key);

  @override
  _consultaProductosState createState() => _consultaProductosState();
}

class _consultaProductosState extends State<consultaProductos> {
  List datos_productos = [];

  void initState() {
    super.initState();
    getCriterio();
  }

  void getCriterio() async {
    CollectionReference datos =
    FirebaseFirestore.instance.collection('Productos');
    QuerySnapshot producto  = await datos.where('Id', isEqualTo: widget.id).get();
    if (producto.docs.length != 0) {
      for (var per in producto.docs) {
        print(per.data());
        setState(() {
          datos_productos.add(per);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build



    return Scaffold(
        appBar: AppBar(
          title: Text('Información del producto'),
        ),
        body: Column(children: [

          Container(
            margin: const EdgeInsets.all(50.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: datos_productos.length,
              itemBuilder: (BuildContext context, i) {
                var img = "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/icono-tienda.jpg";

                var urlimage= 'https://source.unsplash.com/random/800x600?market';

                // ESTO FUE NECESARIO YA QUE NO TODOS LOS REGISTROS TRAEN LOGO, DEBERIAN TRAER LOGO O UNA IMAGEN POR DFEFECTO PARA EVITAR ESTO
                if ( datos_productos[i].data()!["Logo"] != null &&  datos_productos[i].data()!["Logo"] != "") {
                  img = datos_productos[i]['Logo'];
                }

                if ( datos_productos[i].data()!['Foto'] != null && datos_productos[i].data()!['Foto'] != "") {
                  urlimage = datos_productos[i]['Foto'];
                }

                var cardImage = NetworkImage(
                    urlimage);

                return Card(
                    child:
                    Column(

                        children: [
                          ListTile(
                            // trailing: Icon(Icons.favorite_outline),
                            title: Text(datos_productos[i]['Producto'].toString()),
                            subtitle: Text(
                              datos_productos[i]['Unidad Medida'].toString(),
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    img)),
                          ),

                          Container(
                            height: 300.0,
                            child: Ink.image(
                              image: cardImage,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Container(


                            margin: const EdgeInsets.all(10.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Producto: "+ datos_productos[i].data()!['Producto'].toString()),
                                  Text("Precio: "+ datos_productos[i].data()!['Precio Unitario'].toString()),
                                  Text("Unidad Medida: " + datos_productos[i].data()!['Unidad Medida'].toString()),
                                  Text("Categoría: "+ datos_productos[i].data()!['Categoría'].toString()),

                                ]),

                          ),



                        ]

                    )

                );
              },
            ),
          ),
        ]));
  }
}