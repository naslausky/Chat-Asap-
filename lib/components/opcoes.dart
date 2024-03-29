import 'package:flutter/material.dart';
import 'package:chat_asap/controller/preferencias.dart';
import 'package:chat_asap/controller/abridor_url.dart';

class Opcoes extends StatefulWidget {
  const Opcoes({required this.callback, Key? key}) : super(key: key);
  final Function callback;
  @override
  _OpcoesState createState() => _OpcoesState();
}

class _OpcoesState extends State<Opcoes> {
  late bool modoEscuroRequisitadoPeloSistema;
  @override
  Widget build(BuildContext context) {
    modoEscuroRequisitadoPeloSistema =
        ((MediaQuery.of(context).platformBrightness == Brightness.dark) &&
            !(Preferencias.jaEscolheuTema));
    return AlertDialog(
      title: Text("Options:"),
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
                    value: modoEscuroRequisitadoPeloSistema
                        ? true
                        : Preferencias.selecionouTemaEscuro,
                    onChanged: (bool ativado) {
                      Preferencias.selecionouTemaEscuro = ativado;
                      widget.callback();
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('History size:'),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Preferencias.decrementarTamanhoHistorico();
                          widget.callback();
                        },
                        icon: Icon(Icons.remove)),
                    Text('${Preferencias.tamanhoHistorico}'),
                    IconButton(
                        onPressed: () {
                          Preferencias.incrementarTamanhoHistorico();
                          widget.callback();
                        },
                        icon: Icon(Icons.add)),
                  ],
                ),
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
              onTap: () =>
                  AbridorDeURL.abrir('https://www.linkedin.com/in/naslausky/'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Click here to send me a message!",
                    textAlign: TextAlign.center,
                  ),
                  //Icon(Icons.airline_seat_flat)
                ],
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
