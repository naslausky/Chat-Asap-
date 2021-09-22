import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chat_asap/components/item_pais_widget.dart';
import 'package:chat_asap/controller/preferencias.dart';
import 'package:chat_asap/components/historico.dart';
import 'package:chat_asap/components/opcoes.dart';

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
  String numeroDigitado = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
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
                      initialValue: 'BR',
                      itemBuilder: (Country country) =>
                          CountryRowWidget(country: country),
                      priorityList: [
                        CountryPickerUtils.getCountryByIsoCode('BR'),
                      ],
                      sortComparator: (Country a, Country b) =>
                          a.isoCode.compareTo(b.isoCode),
                      onValuePicked: (Country country) {
                        paisSelecionado = country;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Full phone number',
                        hintText: 'City code included',
                      ),
                      onChanged: (String numero) {
                        numeroDigitado = numero;
                      },
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
                        paisSelecionado.phoneCode + numeroDigitado;
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

  _abrirConversa(String phone) async {
    String universalLinkWhatsapp = 'https://wa.me/';
    String url = universalLinkWhatsapp + phone;
    if (await canLaunch(url)) {
      await launch(url);
      Preferencias.adicionarNumeroAoHistorico(phone);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Unable to open Whatsapp.'),
      ));
    }
    setState(() {});
  }
}
