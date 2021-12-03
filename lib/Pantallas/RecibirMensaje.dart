import 'package:firebase_messaging/firebase_messaging.dart';

class recibiendoMensajes{

    FirebaseMessaging mensaje= FirebaseMessaging.instance;

    notificaciones(){

      mensaje.requestPermission();
      mensaje.getToken().then((token){
      print(token);
          print("-------T O K E N -------");
       });
      
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {//se usa cuando la app esta abierta

      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {//se usa cuando la app esta abierta en 2do plano

      });
      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async { //se usa cuando la app esta cerrada
      });

    }
}