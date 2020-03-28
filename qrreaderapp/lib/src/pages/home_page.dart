import 'dart:io';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final scansBloc = new ScansBloc();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScanTodos,
          )
        ],
      ),
      body: _callPage(_currentIndex),
      bottomNavigationBar: _crearBottomNavigatorBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),

    );
  }

  Widget _crearBottomNavigatorBar(){
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        ),
        
      ],
    );
  }

  Widget _callPage(int paginaActual){
    
    switch(paginaActual){
      case 0 : return MapasPage();
      case 1 : return DireccionesPage();
      default: return MapasPage();
    }

  }

  _scanQR(BuildContext context) async{
    
    //https://flutter.dev/docs/development/ui/layout/responsive
    //geo:14.609708,-90.438485


    String futureString = '';

    try{
      futureString = await BarcodeScanner.scan();
    }catch(e){
      futureString = e.toString();
    }

    if(futureString!=null){
      print('Tenemos información');
    }

    if( futureString != null ){
      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScan(scan);

      if( Platform.isIOS ){
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirScan(context,scan);
        });
      }else{
        utils.abrirScan(context, scan);
      }

       
    }

    

  }
}