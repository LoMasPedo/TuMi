import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
/*
class consultaNegocios extends StatefulWidget {
  final String consulta;
  const consultaNegocios(this.consulta,{Key? key}) : super(key: key);

  @override
  _consultaNegociosState createState() => _consultaNegociosState();
}


class _consultaNegociosState extends State<consultaNegocios> {
  List negs = [];

  void initState() {
    super.initState();
    getConsulta();
  }

  void getConsulta() async {
    CollectionReference datos = FirebaseFirestore.instance.collection(
        "Negocios");
    QuerySnapshot negocios2 = await datos.where(
        "Id", isEqualTo: widget.consulta).get();
    if (negocios2.docs.length != 0) {
      for (var neg in negocios2.docs) {
        print(neg.data());
        setState(() {
          negs.add(neg);
        });
      }
    }
  }
}*/