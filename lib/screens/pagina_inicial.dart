import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:chat_asap/controller/abridor_url.dart';
import 'package:chat_asap/components/item_pais_widget.dart';
import 'package:chat_asap/controller/preferencias.dart';
import 'package:chat_asap/components/historico.dart';
import 'package:chat_asap/components/opcoes.dart';
import 'package:chat_asap/components/escolha_mensagem_padrao.dart';

class PaginaInicial extends StatefulWidget {
  PaginaInicial({Key? key, this.title = "", this.callbackAtualizacaoTema})
      : super(key: key);
  final String title;
  final Function? callbackAtualizacaoTema;
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  Country paisSelecionado = CountryPickerUtils.getCountryByIsoCode('BR');

  TextEditingController numeroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => EscolhaMensagemPadrao(),
                  ),
              icon: Icon(Icons.message)),
          IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => Opcoes(
                        callback: widget.callbackAtualizacaoTema ??
                            () => setState(() {}),
                      )),
              icon: Icon(Icons.info))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CountryPickerDropdown(
                      initialValue: Preferencias.ultimoPaisSelecionado,
                      itemBuilder: (Country country) =>
                          CountryRowWidget(country: country),
                      priorityList: [
                        CountryPickerUtils.getCountryByIsoCode(
                            Preferencias.ultimoPaisSelecionado),
                      ],
                      sortComparator: (Country a, Country b) =>
                          a.isoCode.compareTo(b.isoCode),
                      onValuePicked: (Country country) {
                        paisSelecionado = country;
                        Preferencias.ultimoPaisSelecionado =
                            paisSelecionado.isoCode;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: numeroController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Full phone number',
                        hintText: 'City code included',
                        suffixIcon: numeroController.text.length > 0
                            ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: _limparNumeroDigitado,
                              )
                            : null,
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: FloatingActionButton(
                onPressed: () {
                  try {
                    String numeroCompleto =
                        paisSelecionado.phoneCode + numeroController.text;
                    _abrirConversa(numeroCompleto);
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Icon(Icons.perm_phone_msg),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Number history:',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Expanded(
              flex: 3,
              child: Historico(
                  dados: Preferencias.historico.reversed.toList(),
                  callback: _abrirConversa),
            ),
          ],
        ),
      ),
    );
  }

  _limparNumeroDigitado() {
    setState(() {
      numeroController.clear();
    });
  }

  _abrirConversa(String phone) async {
    String universalLinkWhatsapp = 'https://wa.me/';
    String url = universalLinkWhatsapp + phone;
    String mensagemPadrao = Preferencias.mensagemPadrao;
    if (mensagemPadrao.isNotEmpty) {
      String mensagemPadraoCodificada = Uri.encodeComponent(mensagemPadrao);
      print(mensagemPadraoCodificada);
      url = url + '/?text=' + mensagemPadraoCodificada;
    }
    bool conseguiuAbrir = await AbridorDeURL.abrir(url);
    if (conseguiuAbrir) {
      Preferencias.adicionarNumeroAoHistorico(phone);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Unable to open Whatsapp.'),
      ));
    }
    setState(() {});
  }

  @override
  void dispose() {
    numeroController.dispose();
    super.dispose();
  }
}
