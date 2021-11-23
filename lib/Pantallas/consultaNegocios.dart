import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class consultaNegocios extends StatefulWidget {
  final String id;
  const consultaNegocios(this.id, {Key? key}) : super(key: key);

  @override
  _consultaNegociosState createState() => _consultaNegociosState();
}

class _consultaNegociosState extends State<consultaNegocios> {
  List datos_negocios = [];

  void initState() {
    super.initState();
    getCriterio();
  }

  void getCriterio() async {
    CollectionReference datos =
        FirebaseFirestore.instance.collection('Negocios');
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text('Informacion del negocio'),
        ),
        body: ListView(children: [
          Container(
            margin: const EdgeInsets.all(50.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: datos_negocios.length,
              itemBuilder: (BuildContext context, i) {
                var img =
                    "https://raw.githubusercontent.com/festupinans/equipo2_grupo15/master/lib/Imagenes/icono-tienda.jpg";

                var urlimage =
                    'https://source.unsplash.com/random/800x600?market';

                // ESTO FUE NECESARIO YA QUE NO TODOS LOS REGISTROS TRAEN LOGO, DEBERIAN TRAER LOGO O UNA IMAGEN POR DFEFECTO PARA EVITAR ESTO
                if (datos_negocios[i].data()!["Logo"] != null &&
                    datos_negocios[i].data()!["Logo"] != "") {
                  img = datos_negocios[i]['Logo'];
                }

                if (datos_negocios[i].data()!['Foto'] != null &&
                    datos_negocios[i].data()!['Foto'] != "") {
                  urlimage = datos_negocios[i]['Foto'];
                }

                var cardImage = NetworkImage(urlimage);

                return Card(
                    child: Column(children: [
                  ListTile(
                    // trailing: Icon(Icons.favorite_outline),
                    title: Text(datos_negocios[i]['Nombre'].toString()),
                    subtitle: Text(
                      datos_negocios[i]['Tipo'].toString(),
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    leading: CircleAvatar(backgroundImage: NetworkImage(img)),
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
                          Text("Celular: " +
                              datos_negocios[i].data()!['Celular'].toString()),
                          Text("Pagina Web: " +
                              datos_negocios[i]
                                  .data()!['Pagina Web']
                                  .toString()),
                          Text("Telefono: " +
                              datos_negocios[i].data()!['Teléfono'].toString()),
                          Text("Dirección: " +
                              datos_negocios[i]
                                  .data()!['Dirección']
                                  .toString()),
                        ]),
                  ),
                ]));
              },
            ),
          ),
        ]));
  }
}
