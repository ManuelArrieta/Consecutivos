class TiposDocumental
{ 
  String indice;
  String codigoDependencia;
  String codigoSerie;
  String codigoTdocumental;
  String nombre;  

  fromJson(Map<String,dynamic> json)
  {    
    this.indice            = json["indice"];   
    this.codigoDependencia = json["codigo_dependencia"];
    this.codigoSerie       = json["codigo_serie"];
    this.codigoTdocumental = json["codigo_tdocumental"];   
    this.nombre            = json["nombre"];   
  }
}

