class TipoReceta {
  TipoReceta(int idTipoReceta, String nombre);

  int idTipoReceta;
  String nombre;

  TipoReceta.fromJson(Map json) {
    this.idTipoReceta = json["idTipoReceta"];
    this.nombre = json["nombre"];
  }
}
