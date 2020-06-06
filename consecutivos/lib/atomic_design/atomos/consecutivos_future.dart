import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'Dart:io';
import 'package:toast/toast.dart';
import 'consecutivo_model.dart';

//Funcion que hace la consulta externa de forma asincrona
//Future-> Es la representacion abstracta del resultado de una operacion asincrona.
Future<List<Consecutivo>> getConsecutivos(BuildContext context,int operacion, var usuario) async
{ 

  Response respuestaServidor; //Variable que lleva la respuesta del servidor.
  var informacionDecodificada;//Variable que lleva la informacion decodificada de la consulta

  List<Consecutivo> listaConsecutivos = new List<Consecutivo>(); //Lista de consecutivos
    
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
      respuestaServidor = await post
      (
        'http://mivoip.net/api/consultaConsecutivos.php',
        body: 
        json.encode({"op":operacion.toString(),"cedula":usuario["CEDULA"],"codigo_dependencia":usuario["codigo_dependencia"]})
      );

      
      if(respuestaServidor.statusCode == 200)
      {

        informacionDecodificada = jsonDecode(respuestaServidor.body);              
        int numeroElementos = informacionDecodificada.length;        
        //print("--->"+numeroElementos.toString());
        for(int contador=0; contador<numeroElementos;contador++)
        {
          Consecutivo consecutivoTemp = new Consecutivo();
          //print("--->"+informacionDecodificada[contador].toString());
          consecutivoTemp.fromJson(informacionDecodificada[contador]);
          listaConsecutivos.add(consecutivoTemp);
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
    return listaConsecutivos;
}


void postConsecutivo(BuildContext context, String _codigo_dependencia,String _serie, String _tipoDocumental, String  _cedulaUsuario, String _asunto, String _destinatario, String _fechaRegistro) async
{
  Response respuestaServidor; //Variable que lleva la respuesta del servidor.
  var informacionDecodificada;//Variable que lleva la informacion decodificada de la consulta    
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
    respuestaServidor = await post
    (
      'http://mivoip.net/api/addConsecutivo.php',
      body: 
      json.encode({"codigo_dependencia":_codigo_dependencia.toString(),"codigo_serie":_serie,"codigo_tdocumental":_tipoDocumental,"cedula":_cedulaUsuario,"asunto":_asunto,"fechaRegistro":_fechaRegistro,"destinatario":_destinatario})
    );

      
    if(respuestaServidor.statusCode == 200)
    {
      informacionDecodificada = jsonDecode(respuestaServidor.body);              
      print("Respuesta del servidor "+informacionDecodificada.toString());
  
    }
    else
    {
      Toast.show("Error al consultar el servidor!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);                
    }  
  }
  else{
    Toast.show("Problemas de conexion!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);                
  }  
  
}


