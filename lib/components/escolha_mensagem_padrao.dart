import 'package:flutter/material.dart';
import 'package:chat_asap/controller/preferencias.dart';
import 'package:chat_asap/controller/abridor_url.dart';

class EscolhaMensagemPadrao extends StatefulWidget {
  const EscolhaMensagemPadrao({required this.callback, Key? key})
      : super(key: key);
  final Function callback;
  @override
  _EscolhaMensagemPadraoState createState() => _EscolhaMensagemPadraoState();
}

class _EscolhaMensagemPadraoState extends State<EscolhaMensagemPadrao> {
  TextEditingController mensagemPadraoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Default message:"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type in a default message below.'),
            Text(
                'This message will be automatically typed when a new conversation is opened.'),
            Text('Leaving it blank it\'s the same as disabled.'),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              onChanged: (String _) {
                setState(() {});
              },
              controller: mensagemPadraoController,
              decoration: InputDecoration(
                labelText: 'Default message',
                border: OutlineInputBorder(),
                suffixIcon: mensagemPadraoController.text.length > 0
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          mensagemPadraoController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              maxLines: 4,
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text("Ok!"),
          onPressed: () {
            Preferencias.mensagemPadrao = mensagemPadraoController.text;
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
