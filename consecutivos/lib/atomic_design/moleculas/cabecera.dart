import 'package:flutter/material.dart';




class CabeceraState extends State<Cabecera>
{

  @override
  Widget build(BuildContext context)
  {
    return 
    (
      Center
        (          
          child: Container
          (
            child: 
            Column
            (            
              children:
              <Widget>
              [
                Container
                (  
                  width: 180.0,
                  height: 180.0,                             
                  decoration: BoxDecoration
                  (                                                                        
                    image: DecorationImage(image: AssetImage("lib/recursos/icon_escudo.png"),fit: BoxFit.contain)
                  )
                )
                ,
                Container
                (
                  padding:
                  EdgeInsets.only(top: 15)
                  ,
                  child:
                  Text
                  (
                    "Consecutivos",
                    style: TextStyle(fontSize: 30, color: Colors.black)
                  ) 
                )                
              ]
            )
            ,
            padding: EdgeInsets.only(top: 40),
          )
        )
    );
  }

}

class Cabecera extends StatefulWidget
{
  @override
  CabeceraState createState() => CabeceraState();
}