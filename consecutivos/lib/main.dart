import 'package:consecutivos/atomic_design/plantillas/cpanel.dart';
import 'package:flutter/material.dart';
import 'package:consecutivos/atomic_design/plantillas/login.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'atomic_design/atomos/conexion.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  var usuario;
  bool conexion;

  MyApp()
  {
    // Verificamos que haya una conexion
    getConexion().then((conexion) => this.conexion=conexion);
  }

  @override
  Widget build(BuildContext context)
  {
    return
    (
      MaterialApp
      (
        home: FutureBuilder
        (
          future: cargarDatos(), // Cargamos los datos del usuario almacenados localmente
          
          builder:(BuildContext context, AsyncSnapshot snapshot)
          {
              if(snapshot.connectionState ==  ConnectionState.waiting)
              {
                return Center(child: CircularProgressIndicator());               
              }
              else
              { 
                if(snapshot.connectionState ==  ConnectionState.done )
                {
                  
                  if(this.usuario!=null && this.conexion)
                  {
                    return Cpanel(usuario: this.usuario);
                  }
                  else
                  {
                    if(!this.conexion) Toast.show("Error de conexion a Internet!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                    return Login();
                  }
                }                
              }
            }
        )
      )
    );
  }


  // Funcion que carga los datos del usuario delde el dispositivo
 Future<void> cargarDatos() async
  {
    //1->Cargamos los datos locales desde main
    await SharedPreferences.getInstance().
    then
    (
      (instanciaDatosLocal)
      {
        //2->Se consulta primera vez usuario en main
        if(instanciaDatosLocal.getString("usuarioJson") != null)
        {
          this.usuario = jsonDecode(instanciaDatosLocal.getString("usuarioJson"));              
        }                  
      }
    );    
  }  
    
}