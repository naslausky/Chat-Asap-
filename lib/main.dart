import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chat_asap/components/item_pais_widget.dart';

void main() => runApp(MyApp());

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

class PaginaInicial extends StatefulWidget {
  PaginaInicial({Key? key, this.title = ""}) : super(key: key);
  final String title;
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                        //hintText: '',
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
            )
          ],
        ),
      ),
    );
  }

  _abrirConversa(String phone) async {
    //String intentWhatsapp = 'whatsapp://send?';
    String universalLinkWhatsapp = 'https://wa.me/';
    String url = universalLinkWhatsapp + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Não foi possível abrir o Whatsapp.'),
      ));
    }
  }
}
