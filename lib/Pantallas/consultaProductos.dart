import 'package:equipo2_grupo15/Pantallas/BkTiendas.dart';
import 'package:equipo2_grupo15/Pantallas/negocios.dart';
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
  List datos_negocios = [];

  void initState() {
    super.initState();
    getCriterio();
    getNegocios();
  }

  void getNegocios() async {
    CollectionReference datos= FirebaseFirestore.instance.collection('Negocios'); //Conecta a la conexion
    QuerySnapshot negocios= await datos.get(); //Traer todas los ngocios
    if(negocios.docs.length>0){
      for(var doc in negocios.docs){
        //var data =  doc.data();
        var productosResultado = [];
        try {
          var productos = doc["Productos"];

          if (productos.length != 0) {
            for (var i = 0; i < productos.length; i++) {
              var productoInfo = productos[i];
              var productoCompleto = await productoInfo["Producto"].get();
              productosResultado.add({"precio":productoInfo["Precio"],
                "Unidades":productoInfo["Unidades"],
                "Producto": productoCompleto.data()
              });
            }
          }
        }catch(error){
          print(error);
          //es por que no existen productos en el negocio
          print(doc["Nombre"] +" no tiene productos, agregar en la base de datos");

        }

        tiendaOnTAP tienda = tiendaOnTAP(
          doc['Nombre'],
          doc['Celular'],
          doc['Tipo'],
          doc['Categoria'],
          doc['Foto'],
          doc['Dirección'],
          doc['Id'],
          doc['Geolocalización'],
          doc['Teléfono'],
          doc['Pagina Web'],
          doc['Logo'],
          productosResultado,
        );

        setState(() {
          datos_negocios.add(tienda);
        });
      }
    }else{
      print('ha fallado....');
    }
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
      body: ListView(
          children: [

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
                                    Text("Categoría: "+ datos_productos[i].data()!['Categoria'].toString()),
                                    Text("Negocio: "+ datos_productos[i].data()!['Id'].toString()),
                                  ]
                              ),
                            ),
                          ]
                      )
                  );
                },
              ),
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
          //Navigator.push(context, MaterialPageRoute(builder:(context)=> BkTienda(tienda: tiendaOnTAP(nombre, celular, tipo, categoria, foto, direccion, id, geolocalizacion, telefono, pagina, logo, productos))));
          //Navigator.push(context,MaterialPageRoute(builder: (context)=>BkTiendas(tienda: datos_negocios[i])));
        },

        label: Text("Ir a la tienda"),
        icon: Icon(Icons.arrow_forward_ios),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}