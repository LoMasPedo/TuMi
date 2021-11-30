import 'package:equipo2_grupo15/Pantallas/seleccion_cliente.dart';
import 'package:flutter/material.dart';
import 'package:equipo2_grupo15/Pantallas/negocios.dart';

class loginTendero extends StatefulWidget {
  const loginTendero({Key? key}) : super(key: key);

  @override
  _loginTenderoState createState() => _loginTenderoState();
}

class _loginTenderoState extends State<loginTendero> {
  @override
  String UsuarioT="";
   String PasswordT="";
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
        title: Text("Login del Veci"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 50.0),
            child: Image.network('https://github.com/festupinans/equipo2_grupo15/blob/master/lib/Imagenes/TuMi2.png?raw=true'),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (usuariot){
                setState(() {
                  UsuarioT=usuariot;
                });
                print(UsuarioT);
              },
              autofocus: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle_rounded, color: Color(0xFFFF6961)),border: OutlineInputBorder(),
                  hintText: "Ingrese su nombre"
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (passwordt){
                setState(() {
                  PasswordT=passwordt;
                });
                print(PasswordT);
              },
              obscureText: true,
              autofocus: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password, color: Color(0xFFFF6961)),border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            child:
              login(),
          ),
          Container(
            child:
              register(),
          ),
        ],

      ),
    );
  }
}

class login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        child:
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF6961),

                textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold)),
            onPressed: (){
              //aqui se pone el salto de pagina
              Navigator.push(context, MaterialPageRoute(builder: (context)=>seleccionCliente()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Login'),
                Icon(Icons.arrow_forward_sharp)
              ],
            )
        )
    );

  }
}

class register extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        child:
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF6961),

                textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold)),
            onPressed: (){
              //aqui se pone el salto de pagina
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>loginUsuarios()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Register'),
                Icon(Icons.arrow_forward_sharp)
              ],
            )
        )
    );

  }
}
