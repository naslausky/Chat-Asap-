import 'package:flutter/material.dart';
import 'package:chat_asap/controller/preferencias.dart';
import 'package:url_launcher/url_launcher.dart';

class Opcoes extends StatefulWidget {
  const Opcoes({required this.callback, Key? key}) : super(key: key);
  final Function callback;
  @override
  _OpcoesState createState() => _OpcoesState();
}

class _OpcoesState extends State<Opcoes> {
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Options"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Toogle dark mode:'),
                Switch(
                    value: Preferencias.selecionouTemaEscuro,
                    onChanged: (bool ativado) {
                      Preferencias.selecionouTemaEscuro = ativado;
                      widget.callback();
                    }),
              ],
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    Preferencias.limparHistorico();
                    widget.callback();
                  },
                  child: Text('Clear phone history')),
            ),
            Divider(),
            GestureDetector(
              onTap: () => _launchURL('https://www.linkedin.com/in/naslausky/'),
              child: Text(
                "Made by: Naslausky",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
