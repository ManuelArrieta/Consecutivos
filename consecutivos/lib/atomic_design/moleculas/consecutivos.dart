import 'package:flutter/material.dart';
import 'package:consecutivos/atomic_design/atomos/consecutivos_future.dart';
import '../atomos/consecutivo_model.dart';




class ConsecutivosWidgetState extends State<ConsecutivosWidget>
{
  String filtro;  
  final usuario;
  var operacion;
  var consecutivos;
  var datosAsincronos;
  var textoEncabezado;
  ListaConsecutivos listaConsecutivos;
  BuildContext contextActual;

  ConsecutivosWidgetState({@required this.operacion, @required this.usuario, @required this.filtro});
  

  @override
  Widget build(BuildContext context)
  {                    
    this.contextActual = context;
    return
    (
      Container
      (             
        child:
        Column
        (
          children: <Widget>
          [            
            FutureBuilder
            (
              future: getConsecutivos(context,this.operacion,this.usuario),
              builder: (BuildContext context, AsyncSnapshot snapshot)
              {
                if(snapshot.connectionState ==  ConnectionState.waiting)
                {
                  return Center(child: CircularProgressIndicator());               
                }
                else
                {
                  this.datosAsincronos = snapshot.data;
                  this.listaConsecutivos = new ListaConsecutivos(this.datosAsincronos,this.operacion,this.filtro);                            
                  return this.listaConsecutivos;
                }
              }
            )
          ]
        )        
      )
    );
  }
  updateList()
  {
    Future query = getConsecutivos(this.contextActual,0,this.usuario);
    query.then(
      (value){        
        setState(() {
          this.listaConsecutivos = new ListaConsecutivos(value,0,"");                                      
        }); 
      });

  }
  setFiltros(String filtro)
  {
    setState(() {
      this.filtro = filtro;      
    });
  }
  setOperacion(var operacion)
  {
    setState(() {
      this.operacion = operacion;      
    });
  }
}

class ConsecutivosWidget extends StatefulWidget
{  
  final filtro;
  final usuario;
  var operacion;
  ConsecutivosWidgetState stateConsecutivoWidget;
  ConsecutivosWidget({@required this.operacion, @required this.usuario,@required this.filtro})
  {
    this.stateConsecutivoWidget = new ConsecutivosWidgetState(operacion: this.operacion, usuario: this.usuario, filtro: this.filtro);
  } 

  @override
  ConsecutivosWidgetState createState()=> this.stateConsecutivoWidget;

  setFiltros(String filtro)
  {
    this.stateConsecutivoWidget.setFiltros(filtro);
  }
  setOperacion(var operacion)
  {
    this.stateConsecutivoWidget.setOperacion(operacion);
  }

  updateList()
  {this.stateConsecutivoWidget.updateList();}
}

class ListaConsecutivos extends StatelessWidget
{

  List<Consecutivo> listaConsecutivos;
  final operacion;
  final filtro;
  List<Consecutivo>       listaConsecutivosMostrar;

  ListaConsecutivos(this.listaConsecutivos,this.operacion,this.filtro);  

  @override
  Widget build(BuildContext context)
  {     
    if(this.filtro=="" || this.filtro==null)
    {    
      this.listaConsecutivosMostrar = listaConsecutivos;
    }
    else
    {          
      this.listaConsecutivosMostrar = this.listaConsecutivos.where((consecutivo) => consecutivo.asunto.toLowerCase().contains(this.filtro.toLowerCase()) || consecutivo.destinatario.toLowerCase().contains(this.filtro.toLowerCase()) || consecutivo.nombreUsuario.toLowerCase().contains(this.filtro.toLowerCase()) || consecutivo.fechaRegistro.toLowerCase().contains(this.filtro.toLowerCase()) ).toList();      
    }    
    return  
    Container
    (
      width: 300,
      height: 420,
      child:
      ListView.builder
      (
        itemCount: listaConsecutivosMostrar.length,
        itemBuilder: (BuildContext context, int index)
        {
          return
          Card
          (
            child: 
            ListTile
            (              
              title:
              Text
              (
                this.listaConsecutivosMostrar.elementAt(index).codigoDependencia+"-"+
                this.listaConsecutivosMostrar.elementAt(index).codigoSerie+"-"+
                this.listaConsecutivosMostrar.elementAt(index).codigoTdocumental+"-"+
                this.listaConsecutivosMostrar.elementAt(index).consecutivo
              )
              ,
              subtitle:
              Text
              (
                "Asunto: "+this.listaConsecutivosMostrar.elementAt(index).asunto.toString()+'\n'+                
                "Destinatario: "+this.listaConsecutivosMostrar.elementAt(index).destinatario.toString()+'\n'+
                "Usuario: "+this.listaConsecutivosMostrar.elementAt(index).nombreUsuario.toString()+'\n'+
                "Fecha de registro: "+this.listaConsecutivosMostrar.elementAt(index).fechaRegistro.toString()+'\n'
              )
              ,
              trailing: 
              this.operacion==0?Icon(Icons.grade):Icon(Icons.lens)

            )
          );     
        }
      )            
    );
  }

}



