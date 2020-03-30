import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';


class HomePage extends StatelessWidget {
  
  

  @override
  Widget build(BuildContext context) {

     final productosBloc = Provider.productosBloc(context);
     productosBloc.cargarProductos();
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }

  Widget _crearListado(ProductosBloc productosBloc){
    
    return StreamBuilder(
      stream: productosBloc.productosStream ,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        
        if(snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context,i) {
              return _crearItem(context,productosBloc, productos[i]);
            },
          );
        }else {
          return Center(child: CircularProgressIndicator());
        }
      },

    );
  }

  Widget _crearItem(BuildContext context,ProductosBloc productosBloc, ProductoModel producto){
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction){ productosBloc.borrarProducto(producto.id); },
      background: Container(
        color: Colors.redAccent
      ),
      child: Card(
        child: Column(
          children: <Widget>[
            (producto.fotoUrl == null) 
              ? Image(image: AssetImage('assets/no-image.jpg'))
              : FadeInImage(
                image: NetworkImage(producto.fotoUrl),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover
              ),
              ListTile(
                title: Text('${producto.titulo} - ${producto.valor}'),
                subtitle: Text(producto.id),
                onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto),

              ), 
          ],
        ),
      )
    );
  }

}