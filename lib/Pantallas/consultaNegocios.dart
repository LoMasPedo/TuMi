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
        body: Column(children: [

          Container(
            margin: const EdgeInsets.all(50.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: datos_negocios.length,
              itemBuilder: (BuildContext context, i) {
                var img =
                    "https://i.pinimg.com/736x/28/f1/a9/28f1a972e13e4281b5273891ead173eb.jpg";
                if (datos_negocios[i]['Logo'] != null) {
                  img = datos_negocios[i]['Logo'];
                }

                var urlimage= 'https://source.unsplash.com/random/800x600?market';
                if (datos_negocios[i]['Foto'] != null) {
                  urlimage = datos_negocios[i]['Foto'];
                }


                var cardImage = NetworkImage(
                    urlimage);

                return Card(
                    child: /*ListTile(
                  title: Text(datos_negocios[i]['Nombre'].toString()),
                  subtitle: Text(datos_negocios[i]['Id'].toString()),
                  leading: CircleAvatar(backgroundImage: NetworkImage(img)),
                  trailing: Icon(Icons.add_business_outlined),
                )*/
                    Column(
                        children: [
                          ListTile(
                           // trailing: Icon(Icons.favorite_outline),
                            title: Text(datos_negocios[i]['Nombre'].toString()),
                            subtitle: Text(
                              datos_negocios[i]['Id'].toString(),
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      img)),
                          ),

                          Container(
                            height: 50.0,
                            child: Ink.image(
                              image: cardImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(datos_negocios[i]['Celular'].toString()),
                          Text(datos_negocios[i]['Pagina Web'].toString()),
                          Text(datos_negocios[i]['Teléfono'].toString()),
                          Text(datos_negocios[i]['Geolocalización'].toString()),

                        ]

                    )

                );
              },
            ),
          ),
        ]));
  }
}
