import 'package:flutter/material.dart';

class loginClientes extends StatefulWidget {
  const loginClientes({Key? key}) : super(key: key);

  @override
  _loginClientesState createState() => _loginClientesState();
}

class _loginClientesState extends State<loginClientes> {
  @override
  String UsuarioT="";
   String PasswordT="";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login del Cliente"),
      ),
      body: Column(
        children: <Widget>[
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
                  prefixIcon: Icon(Icons.account_circle_rounded, color: Colors.cyan),border: OutlineInputBorder(),
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
                prefixIcon: Icon(Icons.password, color: Colors.cyan),border: OutlineInputBorder(),
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
        child:
        ElevatedButton(
            onPressed: (){
              //aqui se pone el salto de pagina
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>loginUsuarios()));
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
        child:
        ElevatedButton(
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