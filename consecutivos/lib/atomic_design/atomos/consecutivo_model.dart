class Consecutivo
{ 
  String indice;
  String codigoDependencia;
  String codigoSerie;
  String codigoTdocumental;
  String consecutivo;
  String cedula;
  String asunto;
  String fechaRegistro;
  String destinatario;
  String nombreUsuario;
  String nombreDependencia;

  fromJson(Map<String,dynamic> json)
  {
    this.indice            = json["indice"];
    this.codigoDependencia = json["codigo_dependencia"];
    this.codigoSerie       = json["codigo_serie"];
    this.codigoTdocumental = json["codigo_tdocumental"];
    this.consecutivo       = json["consecutivo"];
    this.asunto            = json["asunto"];
    this.fechaRegistro     = json["fechaRegistro"];
    this.destinatario      = json["destinatario"];
    this.cedula            = json["cedula"];
    this.nombreUsuario     = json["nombreUsuario"];
    this.nombreDependencia = json["nombreDependencia"];  
  }
}
