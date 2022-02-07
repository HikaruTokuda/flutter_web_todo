import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/top_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCTtWUHKBF1ttD3jRfffiNaNdXPSIHyyPg",
        appId: "1:781222392442:web:a6fcf3b9820dcb83f4c1c3",
        messagingSenderId: "781222392442",
        projectId: "fir-task-app-5cbc4"
    )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TopPage(title: 'Flutter Demo Home Page'),
    );
  }
}
