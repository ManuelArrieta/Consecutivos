import 'dart:io';

Future<bool> getConexion() async
{
  // Verificamos la conectividad
    bool conexion = false;
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

    return conexion;
}