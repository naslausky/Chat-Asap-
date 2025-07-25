import 'package:chat_asap/controller/preferencias.dart';
import 'package:chat_asap/screens/pagina_inicial.dart';
import 'package:flutter/material.dart';

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
    bool jaMudouTema = Preferencias.jaEscolheuTema;

    return MaterialApp(
      title: 'Chat ASAP!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: jaMudouTema
          ? (selecionouTemaEscuro ? ThemeMode.dark : ThemeMode.light)
          : ThemeMode.system,
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
