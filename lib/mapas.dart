import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Pantallas/negocios.dart';
//import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class mapas extends StatefulWidget {
  //const mapas({Key? key }) : super(key: key);
  //final String geolocalizacion;
  final tiendaOnTAP tienda;

  const mapas({required this.tienda});


  @override
  _mapasState createState() => _mapasState();
}

class _mapasState extends State<mapas> {

 // late GeoPoint pos =

  @override
  Widget build(BuildContext context) {

    double Lat = double.parse(widget.tienda.Geolocalizacion.toString().split(",")[0]);//.slip(",")[0];
    double Lng = double.parse(widget.tienda.Geolocalizacion.toString().split(",")[1]);


    final posicion = CameraPosition(target: LatLng(Lat,Lng),
    zoom: 15
    );

    final Set<Marker> marcador = Set();
    
    marcador.add(Marker(
        markerId: MarkerId(widget.tienda.id),

        visible: true,
        position: LatLng(Lat,Lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(
            title: widget.tienda.Nombre,
            snippet: "Tel: "+ widget.tienda.Celular +" Dir: "+ widget.tienda.Direccion
        )
    ));


    return Scaffold(

      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  Color(0xFF61D5D4),
                  Color(0xFFFF6961)
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )
          ),
        ),
        title: Text ("Geolocalización"),
      ),
      body: Container(
        width: 400,
        height: 600,
        child: GoogleMap(
          initialCameraPosition : posicion,
          scrollGesturesEnabled: true,//activar - desactivar mover el mapa
          zoomGesturesEnabled: false,//activar - desactivar zoom con la mano
          zoomControlsEnabled: true,// desactivar botones zomm
          mapType: MapType.normal,
          markers: marcador,
        ),
      ),
    );
  }
}
