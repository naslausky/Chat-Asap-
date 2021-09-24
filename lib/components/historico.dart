import 'package:flutter/material.dart';

class Historico extends StatelessWidget {
  const Historico(
      {required List<String> this.dados, required this.callback, Key? key})
      : super(key: key);
  final List<String> dados;
  final Function(String) callback;
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black,
      child: ListView.builder(
        itemCount: dados.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text('+' + dados[index]),
          trailing: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => callback(dados[index]),
          ),
        ),
      ),
    );
  }
}
