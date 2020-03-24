import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  final textStyle = new TextStyle(fontSize: 25.0);
  final int conteo = 10;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Titulo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Número de clicks:', style: textStyle,),
            Text('$conteo', style: textStyle,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {},
      ),
    );
  }

}