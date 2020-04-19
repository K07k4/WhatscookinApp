class Receta {
  Receta(
      int idReceta,
      int idTipoReceta,
      String instrucciones,
      String titulo,
      int idDificultad,
      int idUsuario,
      int duracion,
      double puntuacion,
      int numeroPuntuaciones);

  int idReceta;
  int idTipoReceta;
  String instrucciones;
  String titulo;
  int idDificultad;
  int idUsuario;
  int duracion;
  double puntuacion;
  int numeroPuntuaciones;

  Receta.fromJson(Map json) {
    this.idReceta = json["idReceta"];
    this.idTipoReceta = json["idTipoReceta"];
    this.instrucciones = json["instrucciones"];
    this.titulo = json["titulo"];
    this.idDificultad = json["idDificultad"];
    this.idUsuario = json["idUsuario"];
    this.duracion = json["duracion"];
    this.puntuacion = json["puntuacion"];
    this.numeroPuntuaciones = json["numeroPuntuaciones"];
  }
}
