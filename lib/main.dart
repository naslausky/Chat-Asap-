import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat ASAP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Chat ASAP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CountryPickerDropdown(
                    initialValue: 'BR',
                    itemBuilder: _construirItemDropdown,
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
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

  Widget _construirItemDropdown(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );

  _abrirConversa(String phone) async {
    String universalLinkWhatsapp = 'https://wa.me/';
    String intentWhatsapp = 'whatsapp://send?';
    String url = universalLinkWhatsapp + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
