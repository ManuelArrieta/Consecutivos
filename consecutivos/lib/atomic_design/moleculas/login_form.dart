import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:consecutivos/atomic_design/plantillas/cpanel.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';




class LoginFormState extends State<LoginForm>
{
  
  var usuario;
  var controladorTextoNombreUsuario = TextEditingController();
  var controladorTextoPassword = TextEditingController(); 
  
   @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    controladorTextoNombreUsuario.dispose();
    controladorTextoPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext loginContext)
  { 
    return
    (
      Column
      (                
        crossAxisAlignment: CrossAxisAlignment.center,            
        mainAxisAlignment: MainAxisAlignment.center,                
        children:<Widget>
        [
          Container
          (
            padding: EdgeInsets.only
            (
              left: 80,
              right: 80,
              top: 40
            ),
            child: Column
            (
              children: <Widget>
              [

                TextField
                (                
                  enabled: true,
                  autofocus: true,                
                  textAlign: TextAlign.center,
                  controller: controladorTextoNombreUsuario,
                  decoration: const InputDecoration
                  (                                                    
                    labelText: 'Nombre de usuario'                    
                  )
                )
                ,
                TextFormField
                (
                  enabled: true,
                  autofocus: true,
                  obscureText: true,
                  controller: controladorTextoPassword,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration
                  (                           
                    labelText: 'Contraseña'                                                        
                  )
                ),
                Container
                (
                  child: 
                  RaisedButton
                  (
                    child: Text('Iniciar sesion'),
                    onPressed: (){iniciarsesion(loginContext);}
                  )
                  ,
                  padding:
                  EdgeInsets.only(top: 20)
                )
              ]
            )
          )                  
        ]
      )
    );
    
  }  

  Future<void> guardarDatos(String datosUsuario) async
  {
    final datosLocales = SharedPreferences.getInstance();
    datosLocales.then((instanciaDatosLocal)
    {
      setState(() {
        
        instanciaDatosLocal.setString("usuarioJson", datosUsuario);
        print("1-> Se almacena el usuario en sharedpreference Loginform");        
      });            
    });
  }



  Future<void> iniciarsesion(BuildContext context) async
  {
    Response respuestaServidor = await post('http://mivoip.net/api/',
      body: json.encode({"cedula":this.controladorTextoNombreUsuario.text,"password":this.controladorTextoPassword.text}));
    if(respuestaServidor.statusCode == 200)
    {        
      //print(respuestaServidor.statusCode);
      if(respuestaServidor.body != "false")
      {
        print("Respuesta del servidor "+respuestaServidor.body);
        this.usuario = jsonDecode(respuestaServidor.body);
        guardarDatos(respuestaServidor.body);
        print(usuario);
        toCpanel(context);
      }
      else
      {
        print("Usuario Errado");
        Toast.show("Usuario o contraseña erradas", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);          
      }    
    }
    else
    {
      Toast.show("Error al consultar el servidor!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);                
    }            
  }
    

  Future toCpanel(context)async
  {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Cpanel(usuario: this.usuario)));
  }
}



class LoginForm extends StatefulWidget
{
  // This widget is the root of your application.
  @override
  LoginFormState createState() =>LoginFormState();
    
}






