import 'package:flutter/material.dart';
import 'package:chat_asap/screens/pagina_inicial.dart';
import 'package:chat_asap/controller/preferencias.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferencias.inicializar();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    bool selecionouTemaEscuro = Preferencias.selecionouTemaEscuro;
    return MaterialApp(
      title: 'Chat ASAP!',
      theme: selecionouTemaEscuro ? ThemeData.dark() : ThemeData(),
      darkTheme: ThemeData.dark(),
      home: PaginaInicial(
        title: 'Chat ASAP ⚡',
        callbackAtualizacaoTema: _atualizarTema,
      ),
    );
  }

  _atualizarTema() {
    setState(() {});
  }
}
