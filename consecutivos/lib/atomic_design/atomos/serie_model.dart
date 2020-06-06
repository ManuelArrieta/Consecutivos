class Serie
{ 
  
  String codigoDependencia;
  String codigoSerie;
  String nombre;

  fromJson(Map<String,dynamic> json)
  {    
    this.codigoDependencia = json["codigo_dependencia"];
    this.codigoSerie       = json["codigo_serie"];
    this.nombre            = json["nombre"];   
  }
}
