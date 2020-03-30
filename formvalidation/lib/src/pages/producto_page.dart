import 'dart:io';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/productos_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:formvalidation/src/models/producto_model.dart';


class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  ProductosBloc productosBloc;
  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    productosBloc = Provider.productosBloc(context);
    if(prodData!=null){
      producto = prodData;
    }
    
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: _tomarFoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            )
          ),
        ),
      ),
    );

  }

    Widget _crearNombre() {
      return TextFormField(
        initialValue: producto.titulo,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Poducto'
        ),
        onSaved: (value) => producto.titulo = value,
        validator: (value) {
          if(value.length < 3){
            return 'Ingrese el nombre del producto';
          }else{
            return null;
          }
        },
      );
    }

    Widget _crearPrecio() {
      return TextFormField(
        initialValue: producto.valor.toString(),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: 'Precio'
        ),
        onSaved: (value) => producto.valor = double.parse(value),
        validator: (value) {
          if( utils.isNumeric(value) ){
            return null;
          }else{
            return 'Sólo números';
          }
        },
        
      );
    }

    Widget _crearDisponible(){
      return SwitchListTile(
        value: producto.disponible,
        activeColor: Colors.deepPurple,
        title: Text('Disponible'),
        onChanged: (value) => setState(() => producto.disponible = value),
      );
    }

    Widget _crearBoton(){
      return RaisedButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        label: Text('Guardar'),
        icon: Icon(Icons.save),
        onPressed: (_guardando) ? null : _submit,
        color: Colors.deepPurple,
        textColor: Colors.white,
      );
    }

    void _submit() async{
      
      if(!formKey.currentState.validate()) return;

      formKey.currentState.save();

      
      setState((){_guardando = true;});

      if(foto!=null) {
        producto.fotoUrl = await productosBloc.subirFoto(foto);
      }

      if(producto.id != null ){
        productosBloc.editarProducto(producto);
      }else{
        productosBloc.agregarProducto(producto);
      }

      mostrarSnackBar('Registro guardado');

      Navigator.pop(context);




    }

    void mostrarSnackBar(String mensaje) {
      final snackbar = SnackBar(
        content: Text(mensaje),
        duration: Duration(milliseconds: 1500),
      );

      scaffoldKey.currentState.showSnackBar(snackbar);
    }
    
    _mostrarFoto() {
 
      if (producto.fotoUrl != null) {
  
        return Container();
  
      } else {
  
        if( foto != null ){
          return Image.file(
            foto,
            fit: BoxFit.cover,
            height: 300.0,
          );
        }
        return Image.asset('assets/no-image.jpg');
      }
    }


    // _mostrarFoto() {
    //   if(producto.fotoUrl != null ){
    //     //TODO: tengo que hacer esto
    //     return FadeInImage(
    //       image: NetworkImage(producto.fotoUrl),
    //       placeholder: AssetImage('assets/jar-loading.gif'),
    //       height: 300.0,
    //       fit: BoxFit.cover,
    //     );
    //   }else{
    //     return Image(
    //       image: AssetImage(foto?.path ?? 'assets/no-image.jpg'),
    //       height: 300.0,
    //       fit: BoxFit.cover,
    //     );
    //   }
    // }

    _seleccionarFoto() async{
      _procesarImagen(ImageSource.gallery);
    }

    _tomarFoto() async {
      _procesarImagen(ImageSource.camera);
    }

    _procesarImagen(ImageSource origen) async{
       foto = await ImagePicker.pickImage(
        source: origen
      );

      if(foto!=null)  {
        producto.fotoUrl = null;
      }

      setState(() {
        
      });
    }
}