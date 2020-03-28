import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {

  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubtitulo = TextStyle(fontSize: 20.0, color: Colors.grey);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
       child: Column(
          children: <Widget>[
          _crearImagen(),
          _crearTitulo(),
          _crearAcciones(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
        ]
       ),
      )
    );
  }

  Widget _crearImagen(){
      return SafeArea(
        child: Container(
          width: double.infinity,
          child: Image(
                image: NetworkImage('https://images.pexels.com/photos/814499/pexels-photo-814499.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                fit: BoxFit.cover,
          ),
        ),
      );
  }

  Widget _crearTitulo(){
    return SafeArea(
      child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Lago con un puente', style: estiloTitulo),
                        SizedBox(height: 7.0),
                        Text('subtitulo del lago', style: estiloSubtitulo)
                      ],
                    ),
                  ),
                  Icon(Icons.star, color: Colors.red, size: 30.0,),
                  Text('41', style: TextStyle(fontSize: 20.0),),
                ],
              ),
            ),
    );
  }

  Widget _crearAcciones(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _crearAccion(Icons.call, 'CALL'),
        _crearAccion(Icons.near_me, 'ROUTE'),
        _crearAccion(Icons.share, 'SHARE'),
        
      ],
    );
  }

  Widget _crearAccion(IconData icon, String texto){

    return Column(
      children: <Widget>[
        Icon(icon, color: Colors.blue, size: 40.0),
        SizedBox(height: 5.0),
        Text(texto, style: TextStyle( fontSize: 15.0, color: Colors.blue))
      ],
    );

  }

  Widget _crearTexto(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      child: Text(
        'Quis velit Lorem ea in est quis incididunt laboris aute magna aute reprehenderit. Minim ex ad laborum ipsum est et sint cupidatat pariatur proident. Consectetur excepteur dolore veniam consectetur. Amet anim sit sunt nisi non minim pariatur labore quis cillum consectetur.',
        textAlign: TextAlign.justify,
      ),
    );
  }

}