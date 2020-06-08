import 'package:consecutivos/atomic_design/atomos/consecutivos_future.dart';
import 'package:consecutivos/atomic_design/moleculas/seleccion_serieTipoDocumentalWidget.dart';
import 'package:consecutivos/atomic_design/plantillas/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:consecutivos/atomic_design/moleculas/consecutivos.dart';
import 'package:consecutivos/atomic_design/atomos/serie_model.dart';
import 'package:consecutivos/atomic_design/atomos/series_future.dart';
import 'package:consecutivos/atomic_design/atomos/tipo_documental_model.dart';
import 'package:consecutivos/atomic_design/atomos/tipo_documental_future.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice ="E083F2E4D447E5C6CE24CECA21EEC025";

class CpanelState extends State<Cpanel>
{  

  final _adBannerID ="ca-app-pub-8691057045918303/9412131295";  
  BannerAd _bannerAd;

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['Games', 'Puzzles'],
    testDevices: null // Android emulators are considered test devices
  );


  var filtro;
  var usuario;
  var operacion; //{0->Consulta consecutivos del usuario  ::  1->Consulta consecutivos global de la secretaria correspondiente al usuario}
  var contextoActual;  
  var usuarioJsonString;
  String textoEncabezadoLista;
  String textoEncabezadoDrawer;    
  ConsecutivosWidget widgetConsecutivos;
  SeriesTipoDocumentalWidget widgetSeriesTipoDocumental;
  TextEditingController controladorTextoFiltoConsecutivo = TextEditingController();
  TextEditingController controladorTextoAsuntoConsecutivo = TextEditingController();
  TextEditingController controladorTextoDestinatarioConsecutivo = TextEditingController();
  
  // Variables especiales
  List<Serie> listaSeries;
  Future<List<Serie>> consultaSeries;    
  List<TiposDocumental> listaTipoDocumental;
  List<TiposDocumental> listaTipoDocumentoFiltrado;
  Future<List<TiposDocumental>> consultaTipoDocumento;

  

  @override
  dispose()
  {
    _bannerAd?.dispose();
    super.dispose();
  }  

  CpanelState({@required this.usuario})
  {     
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-8691057045918303~7169111337");  
    
    _bannerAd = BannerAd
    (
      adUnitId: "ca-app-pub-8691057045918303/9412131295",
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event)
      {
        if(event == MobileAdEvent.loaded)
        {
          print("SE CARGO EL ADS "+event.toString());
        }
      }
    );
    _bannerAd
    ..load()
    ..show();

    this.filtro = "";
    this.operacion = 0;
    this.textoEncabezadoDrawer = this.usuario["NOMBRE_COMPLETO"];  
    
    // Creamos el widget de consecutivos
    this.widgetConsecutivos = new ConsecutivosWidget(operacion: this.operacion, usuario: this.usuario, filtro: this.filtro);    

    // Consultamos las series de la base de datos
    this.consultaSeries = getSeries(contextoActual).
    then((datos)
    {
      this.listaSeries = datos;

      // Consultamos todos los tipos cocumentales de la base de datos 
      this.consultaTipoDocumento = getTipoDocumental(contextoActual).
      then((datos)
      {
        this.listaTipoDocumental = datos;

        // Creamos el widget de seleccion que contendra todas las series y tipos documentales      
        this.widgetSeriesTipoDocumental = new SeriesTipoDocumentalWidget(listaSeries: this.listaSeries, listaTipoDocumental: this.listaTipoDocumental);
      });
    });        
  }


  @override
  Widget build(BuildContext context)
  { 
    //_bannerAd = createBannerAd()..load()..show();
    this.contextoActual = context;    

    switch(this.operacion)
    {
      case 0:
        this.textoEncabezadoLista = "Mis consecutivos";
        break;
      case 1:
        this.textoEncabezadoLista = "Consecutivos";
        break;
      default:
        this.textoEncabezadoLista = "Titulo por defecto";
    } 
    return
    (
      Scaffold
      (
        drawer: 
        Drawer
        (
          child:
          ListView
          (
            padding: EdgeInsets.zero,
            children: <Widget>
            [
              Container
              (
                //height: 100,
                child:
                DrawerHeader
                (
                  padding: 
                  EdgeInsets.only(top:15)
                  ,
                  decoration:
                  BoxDecoration
                  (
                    color: Colors.cyan,                  
                  )
                  ,
                  child:   
                  Column
                  (
                    children: <Widget>
                    [
                      Container
                      (  
                        width: 90.0,
                        height: 90.0,
                        
                        decoration: BoxDecoration
                        (                                              
                          shape: BoxShape.circle,                  
                          color: Colors.black12,                  
                          image: DecorationImage(image: AssetImage("lib/recursos/icon_consecutivo.png"),fit: BoxFit.contain)
                        )
                      )
                      ,
                      Text
                      (
                        "Consecutivos",                  
                        style:
                        TextStyle
                        (
                          color: Colors.white,
                          fontSize: 24,
                        )                  
                      )
                    ]
                  )                              
                )
              )
              ,
              ListTile
              (
                leading:Icon(Icons.assignment),
                title: Text('Consecutivo globales'),
                onTap:()
                {                  
                  this.operacion = 1;
                  setEncabezadoLista();
                  this.widgetConsecutivos.setOperacion(this.operacion);
                  Navigator.pop(context);  
                }             
              )
              ,
              ListTile
              (
                leading:Icon(Icons.assignment),
                title: Text('Mis consecutivos'),
                onTap:()
                {                  
                  this.operacion = 0;
                  setEncabezadoLista();
                  this.widgetConsecutivos.setOperacion(this.operacion);
                  Navigator.pop(context);  
                }                            
              )
              ,              
              ListTile
              (
                leading: Icon(Icons.power_settings_new),
                title: Text('Cerrar sesion'),
                onTap:(){toLogin();}
              )
              ,
            ]
          ),
        )
        ,
        body: Center
        (
          child:
          Container
          (        
            child:
            Wrap
            (
              children:
              <Widget>
              [
                Column
                (                  
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>
                  [
                    Container
                    (
                      child:
                      Text
                      (                        
                        this.textoEncabezadoLista
                        ,
                        style:
                        TextStyle
                        (
                          color: Colors.black,
                          fontSize: 24                         
                        )
                      ),
                      padding: EdgeInsets.only(top:30)
                    ),
                    Container
                    (
                      width: 100,
                      padding: EdgeInsets.only(bottom: 10),
                      child:
                      TextFormField
                      (
                        enabled: true,                          
                        onChanged: (_)
                        {
                          aplicarFiltro();
                        },                   
                        controller: controladorTextoFiltoConsecutivo,
                        decoration: const InputDecoration
                        (                           
                          labelText: 'Filtro'                                                        
                        )
                      )
                    ),
                    Container
                    ( 
                      width: 300,                                 
                      height: 420,
                      child:
                      //---------------------- WIDGET DE CONSECUTIVOS -------------------//
                      this.widgetConsecutivos                      
                      //---------------------- WIDGET DE CONSECUTIVOS -------------------//
                    ),
                    Row
                    (                      
                      crossAxisAlignment: CrossAxisAlignment.center, 
                      mainAxisAlignment: MainAxisAlignment.end,                      
                      children: <Widget>
                      [
                        Container
                        (
                          child: 
                          this.operacion==0?
                          FloatingActionButton
                          (
                            child:
                            Icon(Icons.add)
                            ,
                            onPressed:
                            ()
                            {                            
                              registroConsecutivo(contextoActual);
                            }
                          )
                          :null
                          ,
                          padding: EdgeInsets.only(right: 10),
                        )
                      ]
                    )                  
                  ],
                )            
              ]
            )
            ,
            padding: EdgeInsets.only(top:10)
          )                 
        ) 
      )
    );
  }

  // Funcion asincrona que elimina del almacenamiento local al usuario
  Future<void> eliminarDatos() async
  {    
    await SharedPreferences.getInstance().
    then
    (
      (instanciaDatosLocal)
      {        
        if(instanciaDatosLocal.getString("usuarioJson") != null)
        {
          instanciaDatosLocal.remove("usuarioJson");              
        }                             
      }
    );    
  }  

  // LogOut
  toLogin()
  {
    eliminarDatos();
    logout(this.contextoActual);
  }

  //Actualizamos el texto del encabezado
  setEncabezadoLista()
  {
    setState
    (()
    {
       if(this.operacion == 0)
      {
      
        this.textoEncabezadoLista = "Mis consecutivos";
      }
      else
      {
        this.textoEncabezadoLista = "Consecutivos";
      } 
    });    

  }

  //Funcion que crea una nueva instancia del widget de consecutivos
  recargarListaConsecutivos()
  {
    setState
    (
      ()
      {
        this.widgetConsecutivos = new ConsecutivosWidget(operacion: this.operacion, usuario: this.usuario, filtro: this.filtro);
      }
    );      
  }

  // Funcion que aplica un filtro al widgets de consecutivos
  aplicarFiltro()
  {
    setState
    (
      ()
      {
        this.filtro = this.controladorTextoFiltoConsecutivo.text;                          
        this.widgetConsecutivos.setFiltros(this.filtro);
      }
      );
  }

  // Funcion que me retorna un Widget dialog para el registro de los consecutivos
  registroConsecutivo(BuildContext contextoActual)
  {
    showDialog
    (
      context: contextoActual,
      builder: (BuildContext context)
      { 
        //Siempre que carguemos el Dialog se tendra que volver a crear la siguiente instancia
        // Creamos el widget de seleccion que contendra todas las series y tipos documentales        
        this.widgetSeriesTipoDocumental = new SeriesTipoDocumentalWidget(listaSeries: this.listaSeries, listaTipoDocumental: this.listaTipoDocumental);   
        return AlertDialog
        (
          
          content:
          Stack
          (
            overflow: Overflow.visible,
            children: <Widget>
            [
              //Boton de cancelar
              Positioned
              (
                right: -40.0,
                top: -40.0,
                child: InkResponse
                (
                  onTap: ()
                  {
                    Navigator.pop(context);                    
                  },
                  child: 
                  CircleAvatar
                  (
                    child: Icon(Icons.close),
                    backgroundColor: Colors.blue,
                  ),
                ),
              )
              ,
              Form
              (                
                child: Column
                (
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>
                  [
                    
                    Padding
                    (
                      padding: EdgeInsets.only(top: 2),
                      child: this.widgetSeriesTipoDocumental
                    )
                    ,                   
                    
                    Padding
                    (
                      padding: EdgeInsets.all(8.0),
                      child:
                      TextFormField
                      (
                        enabled: true,                                                
                        controller: this.controladorTextoAsuntoConsecutivo,
                        decoration: const InputDecoration
                        (                           
                          labelText: 'Asunto'                                                        
                        )
                      )
                    ),
                    Padding
                    (
                      padding: EdgeInsets.all(8.0),
                      child:
                      TextFormField
                      (
                        enabled: true,                                                
                        controller: this.controladorTextoDestinatarioConsecutivo,
                        decoration: const InputDecoration
                        (                           
                          labelText: 'Destinatario'                                                        
                        )
                      )
                    ),
                    Padding
                    (
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton
                      (
                        child: Text("Crear"),
                        onPressed:()
                        {                          
                          addConsecutivo(context);
                          setState(() {
                            this.controladorTextoFiltoConsecutivo.text="";
                            this.filtro = "";                            
                            this.widgetConsecutivos.updateList();                            
                          });
                          Navigator.pop(context);                          
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );         
  }

  
  
  // Funcion que envia un post con toda la informacion para crear el consecutivo
  addConsecutivo(BuildContext context)
  {
    DateTime fecha = DateTime.now();
    String formatoFecha = DateFormat('yyyy-MM-dd').format(fecha);
    
    postConsecutivo(
    context,
    this.usuario["codigo_dependencia"],
    this.widgetSeriesTipoDocumental.getSeleccionActualSerie(),
    this.widgetSeriesTipoDocumental.getSeleccionActualTipoDocumental(),
    this.usuario["CEDULA"].toString(),
    this.controladorTextoAsuntoConsecutivo.text.toString(),
    this.controladorTextoDestinatarioConsecutivo.text.toString(),
    formatoFecha);          

  }

}

class Cpanel extends StatefulWidget
{
  final usuario;
  Cpanel({@required this.usuario});  
  @override
  CpanelState createState()=> CpanelState(usuario: this.usuario);
}

 //Navigator.push(context, MaterialPageRoute(builder: (context) => Cpanel(usuario: this.usuario)));
  Future logout(context) async
  {    
    Navigator.pop(context);
    Navigator.pop(context);    
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  

