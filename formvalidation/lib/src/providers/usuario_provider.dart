import 'dart:convert';

import 'package:formvalidation/src/shared_prefs/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {

  final _prefs = new PreferenciasUsuario();
  final String _fireBaseToken = 'AIzaSyBeJWBMdHt3h9g6PrF_fn65YQYaDGOoXPM';

  Future<Map<String,dynamic>> nuevoUsuario(String email, String password) async{

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_fireBaseToken',
      body: json.encode( authData ));

    Map<String,dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);


    if(decodedResp.containsKey('idToken')){
      _prefs.token = decodedResp['idToken'];
      return {'ok':true, 'token': decodedResp['idToken']};
    }else{
      return {'ok':false, 'mensaje': decodedResp['error']['message']};
    }


  }

  Future<Map<String,dynamic>> login(String email, String password) async{ 

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_fireBaseToken',
      body: json.encode( authData ));

    Map<String,dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);


    if(decodedResp.containsKey('idToken')){
      _prefs.token = decodedResp['idToken'];
      return {'ok':true, 'token': decodedResp['idToken']};
    }else{
      return {'ok':false, 'mensaje': decodedResp['error']['message']};
    }


  }
}