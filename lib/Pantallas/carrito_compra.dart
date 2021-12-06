//import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipo2_grupo15/Pantallas/lista_tiendas.dart';
import 'package:equipo2_grupo15/Pantallas/negocios.dart';
import '../main.dart';
import 'package:equipo2_grupo15/Pantallas/registrar_pedido.dart';
import 'package:equipo2_grupo15/Pantallas/bk_tiendas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'bk_tiendas.dart';
import 'bienvenida.dart';

class carritoCompras extends StatefulWidget {
  final List<produc> pedido;
  final String cedula;
  final String id;

  const carritoCompras({required this.pedido, required this.cedula, required this.id});

  @override
  _carritoComprasState createState() => _carritoComprasState();
}

class _carritoComprasState extends State<carritoCompras> {
  @override
  Widget build(BuildContext context) {
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
        title: Text("Carrito de Compras"),
      ),

      body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: widget.pedido.length,
                itemBuilder: (BuildContext context, i) {
                  return ListTile(
                    title: Text(widget.pedido[i].nombre +
                        "-"+
                        widget.pedido[i].descripcion
                        ),
                    subtitle: Text("   Precio: " +
                        widget.pedido[i].precio +
                        "       \n   Cantidad: " +
                        widget.pedido[i].cantidad.toString() +
                        "       \n   Total: " +
                        widget.pedido[i].total.toString()),
                    trailing: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.red,
                    ),
                    onTap: () {
                      widget.pedido.removeAt(i);
                      setState(() {});
                    },
                  );
                  setState(() {});
                }),
          ),
      ),
      bottomNavigationBar: carritoBar(listaPedido: widget.pedido, negocio: widget.id, cliente: widget.cedula, ),
    );
  }
}

class carritoBar extends StatefulWidget {
  final List<produc> listaPedido;
  final String negocio;
  final String cliente;

  const carritoBar(
      {required this.listaPedido, required this.negocio,required this.cliente});

  @override
  _carritoBarState createState() => _carritoBarState();
}

class _carritoBarState extends State<carritoBar> {
  void registrarDetalle(codP) {
    CollectionReference detalle =
        FirebaseFirestore.instance.collection("DetallePedido");
    for (var dato = 0; dato < widget.listaPedido.length; dato++) {
      detalle.add({
        "pedido": codP,
        "producto": widget.listaPedido[dato].descripcion,
        "cantidad": widget.listaPedido[dato].cantidad,
        "total": widget.listaPedido[dato].total
      });
    }
  }

  void registrarP() {
    DateTime hoy = new DateTime.now();
    DateTime fecha = new DateTime(hoy.year, hoy.month, hoy.day);
    int totalP = 0;
    String codPedido;
    for (int i = 0; i < widget.listaPedido.length; i++) {
      totalP += widget.listaPedido[i].total;
    }
    CollectionReference pedidos = FirebaseFirestore.instance.collection("Pedidos");
    pedidos.add({
      "negocio": widget.negocio,
      "cedula": widget.cliente,
      "fecha": fecha,
      "Total": totalP
    }).then((value) => registrarDetalle(value.id));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: new LinearGradient(
              begin: const FractionalOffset(0.4, 0.1),
              end: const FractionalOffset(1.0, 0.9),
              colors: [Color(0xFF61D5D4), Color(0xFFFF6961)])),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Colors.blue,
              icon: Icon(Icons.add_shopping_cart_sharp, size: 30),
              label: "Agregar\nProducto"),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration, size: 30), label: "TOTAL"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_business_sharp, size: 30),
              label: "Confirmar\nCompra")
        ],
        onTap: (indice) {
          if (indice == 0) {
            Navigator.pop(context);
          } else if (indice == 1) {
            int totalPedido = 0;
            for (int i = 0; i < widget.listaPedido.length; i++) {
              totalPedido += widget.listaPedido[i].total;
            }
            print("Total es: " + totalPedido.toString());
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(
                        "Total de la Compra:",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.all(20.0),
                      content: Text(
                        totalPedido.toString(),
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ));
          } else {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(
                        "Confirmar la Compra:",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.all(23.0),
                      content: Text(
                        "Confirma el registro de la Compra.",
                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              registrarP();
                              Fluttertoast.showToast(
                                  msg: "Pedido Registrado exitosamente.",
                                  fontSize: 15,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(nombre: 'Gracias por', cedula: widget.cliente, apellido: 'Tu Compra')  ));
                            },
                            child: Text("Confirmar")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancelar"))
                      ],
                    ));
          }
        },
      ),
    );
  }
}
