import 'package:shared_preferences/shared_preferences.dart';


class PreferenciasUsuario {


  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  
  PreferenciasUsuario._internal();

  SharedPreferences _prefs;


  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get token {
    return _prefs.getString('token') ?? null;
  }

  set token (String value) {
    _prefs.setString('token', value);
  }

  get getUltimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set setUltimaPagina (String value) {
    _prefs.setString('ultimaPagina', value);
  }

}