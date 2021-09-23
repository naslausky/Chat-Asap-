import 'package:shared_preferences/shared_preferences.dart';

enum Chaves {
  selecionouTemaEscuro,
  ultimasStringsChamadas,
  ultimoPaisSelecionado,
}

class Preferencias {
  static SharedPreferences? prefs;
  static final tamanhoHistorico = 5;
  static final _paisInicialPadrao = "BR";

  static final Map<Chaves, String> _chavesPreferencias = {
    Chaves.selecionouTemaEscuro: 'selecionou_tema_escuro',
    Chaves.ultimasStringsChamadas: 'ultimas_strings_chamadas',
    Chaves.ultimoPaisSelecionado: 'ultimo_pais_selecionado',
  };

  static Future<void> inicializar() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> limparPreferencias() async {
    await prefs?.clear();
  }

  static set selecionouTemaEscuro(bool selecionou) {
    String chave = _chavesPreferencias[Chaves.selecionouTemaEscuro] ?? '';
    prefs?.setBool(chave, selecionou);
  }

  static bool get selecionouTemaEscuro {
    String chave = _chavesPreferencias[Chaves.selecionouTemaEscuro] ?? '';
    if (prefs?.containsKey(chave) ?? false)
      return prefs?.getBool(chave) ?? false;
    else
      return false;
  }

  static set ultimoPaisSelecionado(String codigoPais) {
    String chave = _chavesPreferencias[Chaves.ultimoPaisSelecionado] ?? "";
    prefs?.setString(chave, codigoPais);
  }

  static String get ultimoPaisSelecionado {
    String chave = _chavesPreferencias[Chaves.ultimoPaisSelecionado] ?? "";
    return prefs?.getString(chave) ?? _paisInicialPadrao;
  }

  static List<String> get historico {
    String chave = _chavesPreferencias[Chaves.ultimasStringsChamadas] ?? '';
    if (prefs?.containsKey(chave) ?? false)
      return prefs?.getStringList(chave) ?? [];
    return [];
  }

  static set historico(List<String> historico) {
    String chave = _chavesPreferencias[Chaves.ultimasStringsChamadas] ?? "";
    prefs?.setStringList(chave, historico);
  }

  static void limparHistorico() {
    historico = [];
  }

  static void adicionarNumeroAoHistorico(String novoNumero) {
    List<String> historicoAtual = historico;
    historicoAtual.add(novoNumero);
    if (historicoAtual.length > tamanhoHistorico) {
      historicoAtual.removeAt(0);
    }
    historico = historicoAtual;
  }

  // static set idiomaEscolhido(String idioma) {
  //   String chave = _chavesPreferencias[Chaves.idiomaEscolhido];
  //   prefs.setString(chave, idioma);
  // }
  //
  // static String get idiomaEscolhido {
  //   String chave = _chavesPreferencias[Chaves.idiomaEscolhido];
  //   if (prefs.containsKey(chave)) {
  //     return prefs.getString(chave);
  //   } else {
  //     return NenhumIdiomaEscolhido;
  //   }
  // }
  //
  // static void alternarIdioma() {
  //   int indice = localesSuportados.indexOf(Internacionalizacao.localEscolhido);
  //   indice = (indice + 1) % localesSuportados.length;
  //   String novoIdioma = localesSuportados[indice];
  //   idiomaEscolhido = novoIdioma;
  //   Internacionalizacao.localEscolhido = novoIdioma;
  // }

}
