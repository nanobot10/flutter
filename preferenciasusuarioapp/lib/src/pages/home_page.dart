import 'package:flutter/material.dart';
import 'package:preferenciasusuarioapp/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasusuarioapp/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  
  static final String routeName = 'home';


  @override
  Widget build(BuildContext context) {

     final prefs = new PreferenciasUsuario();
     prefs.setUltimaPagina = HomePage.routeName;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias de usuario'),
        backgroundColor: (prefs.getColorSecundario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Color secundario: ${prefs.getColorSecundario}'),
          Divider(),
          Text('Género: ${prefs.getGenero}'),
          Divider(),
          Text('Nombre de usuario: ${prefs.getNombreUsuario}'),
          Divider(),
        ],
      ),
    );
  }

}