import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  Future<FirebaseApp> initializeFirebase () async {
    var firebase = await Firebase.initializeApp();
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null) {
        print(message.notification?.body);
        print(message.notification?.title);
      }
    });
    return firebase;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          // Initialize FlutterFire:
          future: initializeFirebase(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Center(child: Text("La hemos liado"));
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(child: Text("Conectado a Firebase"));
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Center(child: Text("Cargando"));
          },
        ),
      ),
    );
  }
}

