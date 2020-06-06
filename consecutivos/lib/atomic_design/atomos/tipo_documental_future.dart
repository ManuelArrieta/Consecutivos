import 'package:consecutivos/atomic_design/atomos/tipo_documental_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'Dart:io';
import 'package:toast/toast.dart';

//Funcion que hace la consulta externa de forma asincrona
//Future-> Es la representacion abstracta del resultado de una operacion asincrona.
Future<List<TiposDocumental>> getTipoDocumental(BuildContext context) async
{ 

  Response respuestaServidor; //Variable que lleva la respuesta del servidor.
  var informacionDecodificada;//Variable que lleva la informacion decodificada de la consulta

  List<TiposDocumental> listaTdocumental = new List<TiposDocumental>(); //Lista de consecutivos
    
    // Verificamos la conectividad
    bool conexion;
    try {
      final result = await InternetAddress.lookup('google.com');      
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        conexion = true;
      }
    } 
    on SocketException catch (_)
    {
      conexion = false;
    }

    
    if(conexion == true)
    {
      // Hacemos un post al API con los datos suficientes para obtener la informacion que solicitamos a traves de la variable de operacion
      respuestaServidor = await get('http://mivoip.net/api/consultaTipoDocumental.php');

      
      if(respuestaServidor.statusCode == 200)
      {

        informacionDecodificada = jsonDecode(respuestaServidor.body);              
        int numeroElementos = informacionDecodificada.length;        
        //print("--->"+numeroElementos.toString());
        for(int contador=0; contador<numeroElementos;contador++)
        {
          TiposDocumental serieTemp = new TiposDocumental();
          //print("--->"+informacionDecodificada[contador].toString());
          serieTemp.fromJson(informacionDecodificada[contador]);
          listaTdocumental.add(serieTemp);
        }
        
      }
      else
      {
        Toast.show("Error al consultar el servidor!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);                
      }  
    }
    else{
      Toast.show("Problemas de conexion!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);                
    }  
    return listaTdocumental;
}
