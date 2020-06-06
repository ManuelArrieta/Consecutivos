import 'package:consecutivos/atomic_design/atomos/serie_model.dart';
import 'package:consecutivos/atomic_design/atomos/tipo_documental_model.dart';
import 'package:flutter/material.dart';



class SeriesTipoDocumentalStateWidget extends State<SeriesTipoDocumentalWidget>
{

  List<Serie>listaSeries;  
  var datosAsincronos;
  List<DropdownMenuItem> itemsSeries = [];  
  String seleccionSerie;

  List<TiposDocumental>listaTipoDocumental;  
  List<DropdownMenuItem> itemsTipoDocumental = new List<DropdownMenuItem>();  
  String seleccionTipoDocumental; 

  List<TiposDocumental>listaTipoDocumentalFiltrado= new List<TiposDocumental>();

  SeriesTipoDocumentalStateWidget({@required this.listaSeries, @required this.seleccionSerie, @required this.listaTipoDocumental, @required this.seleccionTipoDocumental})
  {                                                   
    this.listaTipoDocumentalFiltrado = this.listaTipoDocumental.where((elemento) => (elemento.codigoSerie == this.seleccionSerie)).toList();
    this.itemsSeries = this.listaSeries.map((serie) => DropdownMenuItem(child: Text(serie.nombre), value: serie.codigoSerie.toString())).toList();
    this.itemsTipoDocumental = this.listaTipoDocumentalFiltrado.map((tdoc) => DropdownMenuItem(child: Text(tdoc.nombre), value: tdoc.codigoTdocumental.toString())).toList();    
  }

  @override 
  Widget build(BuildContext context)
  {                
          return Container
          (
            width: 300,
            height: 100,
            child:
            Column
            (children:<Widget>
              [
                Container
                (
                 
                  child: 
                  DropdownButton
                  (
                    items: this.itemsSeries,
                    value: this.seleccionSerie,
                      onChanged: (newVal) 
                      {                                    
                        setState
                        (
                          ()
                          {
                            this.seleccionSerie = newVal;                            
                            //print("mi seleccion de serie es: "+seleccionSerie);                          
                            this.listaTipoDocumentalFiltrado = this.listaTipoDocumental.where((elemento) => (elemento.codigoSerie == this.seleccionSerie)).toList();
                            //print("mi seleccion de tipo docum es: "+this.listaTipoDocumentalFiltrado.length.toString());                                                     
                            if(this.listaTipoDocumentalFiltrado.length == 0)
                            {
                              DropdownMenuItem dropTmp = DropdownMenuItem(child: Text("Vacio"), value: "-1");
                              this.itemsTipoDocumental = new List<DropdownMenuItem>();
                              this.itemsTipoDocumental.add(dropTmp);
                              this.seleccionTipoDocumental = "-1";
                            }
                            else
                            {
                              this.itemsTipoDocumental = this.listaTipoDocumentalFiltrado.map((tdoc) => DropdownMenuItem(child: Text(tdoc.nombre), value: tdoc.codigoTdocumental.toString())).toList();
                              this.seleccionTipoDocumental = this.listaTipoDocumentalFiltrado.elementAt(0).codigoTdocumental.toString();
                            }                            
                          }
                        );                                                
                      }
                  )
                )
                ,
                Container
                (
                  child: 
                  DropdownButton
                  (
                    items: this.itemsTipoDocumental,
                    value: this.seleccionTipoDocumental,
                    onChanged: (newVal)
                    {            
                      //print("Se selecciono: "+items.last.value.toString());              
                      setState
                      (
                        ()
                        {                          
                          //print("mi seleccion de tipoDocumental es: "+seleccionTipoDocumental);
                          setState
                          (
                            ()
                            {
                              this.seleccionTipoDocumental = newVal;                              
                            }
                          );
                          //_mySelection = items.last.value.toString();
                        }
                      );
                    }
                  )    
                )
              ]
            )
          );                             
    
    
    
            
  }

  String getSeleccionActualSerie()
  {
    return this.seleccionSerie;
  }
  String getSeleccionActualTipoDocumental()
  {
    return this.seleccionTipoDocumental;
  }
}

class SeriesTipoDocumentalWidget extends StatefulWidget
{
  SeriesTipoDocumentalStateWidget seriesTipoDocumentalState;
  List<Serie> listaSeries;
  List<TiposDocumental> listaTipoDocumental;

  SeriesTipoDocumentalWidget({@required listaSeries, @required listaTipoDocumental})
  {
    this.seriesTipoDocumentalState = new SeriesTipoDocumentalStateWidget
    (
      listaSeries: listaSeries,
      seleccionSerie: listaSeries.elementAt(0).codigoSerie,
      listaTipoDocumental:  listaTipoDocumental,
      seleccionTipoDocumental: listaTipoDocumental.elementAt(0).codigoSerie
    );
  }
  @override
  SeriesTipoDocumentalStateWidget createState()=> this.seriesTipoDocumentalState;

  String getSeleccionActualSerie()
  {
    return this.seriesTipoDocumentalState.getSeleccionActualSerie();
  }
  String getSeleccionActualTipoDocumental()
  {
    return this.seriesTipoDocumentalState.getSeleccionActualTipoDocumental();
  }
}



