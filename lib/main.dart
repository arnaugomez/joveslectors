import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:joveslectors/push_notification_message.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<FirebaseApp> initializeFirebase() async {
    var firebase = await Firebase.initializeApp();
    print(await FirebaseMessaging.instance
        .getToken()); //TOKEN DEL DISPOSITIVO (unico por dispositivo) guardar en la base de datos si se quiere enviar notificaciones a este user
    await FirebaseMessaging.instance.subscribeToTopic(
        "news"); //Mandar notificaciones por topics en vez de por dispositivos
    FirebaseMessaging.onMessage.listen((message) {
      final notification = PushNotificationMessage(
          title: message.notification!.title!,
          body: message.notification!.body!);
      print(notification);
    });
    return firebase;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("La hemos liado"));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                  child: Text(
                      "Conectado a Firebase")); //WebViewContainer("https://jornades.joveslectors.cat"),
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
