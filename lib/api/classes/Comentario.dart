class Comentario {
  Comentario(int idComentario, int idUsuario, int idReceta, String comentario);

  int idComentario;
  int idUsuario;
  int idReceta;
  String comentario;

  Comentario.fromJson(Map json) {
    this.idComentario = json["idComentario"];
    this.idUsuario = json["idUsuario"];
    this.idReceta = json["idReceta"];
    this.comentario = json["comentario"];
  }
}
