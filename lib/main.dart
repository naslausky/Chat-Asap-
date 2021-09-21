import 'package:flutter/material.dart';
import 'package:chat_asap/screens/pagina_inicial.dart';
import 'package:chat_asap/controller/preferencias.dart';

void main() async {
  await Preferences.inicializar();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat ASAP',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: PaginaInicial(title: 'Chat ASAP'),
    );
  }
}
