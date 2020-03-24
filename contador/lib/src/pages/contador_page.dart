import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget {

  @override
  createState() => _ContadorPageState();
  

}

class _ContadorPageState extends State<ContadorPage> {
  
  final _textStyle = new TextStyle(fontSize: 25.0);
  int _conteo = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Stateful'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Número de taps:', style: _textStyle,),
            Text('$_conteo', style: _textStyle,)
          ],
        ),
      ),
      floatingActionButton: _crearBotones()
    );
  }

  Widget _crearBotones(){
    return Row(children: <Widget>[
      SizedBox(width: 30.0),
       FloatingActionButton(
        child: Icon(Icons.exposure_zero),
        onPressed: _reset,
      ),
      Expanded(child: SizedBox()),
       FloatingActionButton(
        child: Icon(Icons.remove),
        onPressed: _sustraer,
      ),
      Expanded(child: SizedBox(width: 5.0)),
       FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _agregar,
      )
    ],
    mainAxisAlignment: MainAxisAlignment.end,
    );
    
    
   
  }


  void _agregar() => setState(() => _conteo++);
  void _sustraer() => setState(() => _conteo--);
  void _reset() => setState(() => _conteo=0);
  
}