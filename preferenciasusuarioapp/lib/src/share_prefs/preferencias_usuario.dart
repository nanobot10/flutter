import 'package:preferenciasusuarioapp/src/pages/home_page.dart';
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

  get getGenero {
    return _prefs.getInt('genero') ?? 1;
  }

  set setGenero (int value) {
    _prefs.setInt('genero', value);
  }

    get getColorSecundario {
    return _prefs.getBool('colorSecundario') ?? false; 
  }

  set setColorSecundario (bool value) {
    _prefs.setBool('colorSecundario', value);
  }

  get getNombreUsuario {
    return _prefs.getString('nombreUsuario') ?? 'Dennis';
  }

  set setNombreUsuario (String value) {
    _prefs.setString('nombreUsuario', value);
  }

  get getUltimaPagina {
    return _prefs.getString('ultimaPagina') ?? HomePage.routeName;
  }

  set setUltimaPagina (String value) {
    _prefs.setString('ultimaPagina', value);
  }

}