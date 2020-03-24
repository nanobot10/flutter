import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://lh3.googleusercontent.com/proxy/76kF06ILLGvKJQIKkdjuBN9rYDIVyc876YOdpVxw2SuYlUkzb4QxtEk18-OUvYmlfzVgJvKr1PIaDe9vdC2bkATbFwVCkmvVzBJqKxyfFovHbit4XQ'),
              radius: 25.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: 10.0
            ),
            child: CircleAvatar(
              child: Text('SL'),
              backgroundColor: Colors.brown,
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          image: NetworkImage('https://laverdadnoticias.com/__export/1580180235362/sites/laverdad/img/2020/01/27/the_batman-_director_comparte_la_primera_foto_oficial_desde_el_set_de_la_pelixcula.jpeg_423682103.jpeg'),
          placeholder: AssetImage('assets/original.gif'),
          fadeInDuration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}