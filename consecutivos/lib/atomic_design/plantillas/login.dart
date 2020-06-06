import 'package:flutter/material.dart';
import 'package:consecutivos/atomic_design/moleculas/pie_pagina.dart';
import 'package:consecutivos/atomic_design/moleculas/cabecera.dart';
import 'package:consecutivos/atomic_design/moleculas/login_form.dart';

class LoginState extends State<Login>
{
  

  final myController = TextEditingController();
   @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return
    (
      MaterialApp
      (
        home: Scaffold
        (          
          body: Wrap
          (
            children: <Widget>
            [
              Cabecera()
              ,
              LoginForm()
              ,
              Piepagina()
            ]
          )
        )
      )
    );
  
  }
  
    
}

class Login extends StatefulWidget
{
  // This widget is the root of your application.
  @override
  LoginState createState() =>LoginState();
    
}


/*

 MaterialApp
      (
        home: Scaffold
        (          
          body: Stack
          (
            children: <Widget>
            [
              Cabecera(),
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
                      top: 120
                    ),
                    child: Column
                    (
                      children: <Widget>
                      [
                        
                        TextField
                        (
                          decoration: const InputDecoration
                          (
                            icon: Icon(Icons.person),
                            hintText: 'What do people call you?',
                            labelText: 'User name'
                          )
                        )
                        ,
                        TextFormField
                        (
                          decoration: const InputDecoration
                          (
                            icon: Icon(Icons.lock_open),                            
                            labelText: 'Password'                                                        
                          )
                        )
                      ]
                    )
                  )                  
                ]
              ),
              Piepagina()
            ]
          )
        )
      )
*/