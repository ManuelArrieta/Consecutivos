import 'package:flutter/material.dart';




class PiepaginaState extends State<Piepagina>
{

  @override
  Widget build(BuildContext context)
  {
    return 
    (
     Center
     (
       child: 
       Container
        (
          child:
          Column
          (
            crossAxisAlignment: CrossAxisAlignment.center,            
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>
            [
              Container
                (  
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration
                  (                    
                    
                    shape: BoxShape.circle,                  
                    color: Colors.black12,                  
                    image: DecorationImage(image: AssetImage("lib/recursos/icon_hydra.png"),fit: BoxFit.contain)
                  )
                )      
            ]
          ),
          padding: EdgeInsets.only(top:60),
        )
     )
    );
  }

}

class Piepagina extends StatefulWidget
{
  @override
  PiepaginaState createState() => PiepaginaState();
}