class Favorito {
  Favorito(int idFavorito, int idUsuario, int idReceta);

  int idFavorito;
  int idUsuario;
  int idReceta;

  Favorito.fromJson(Map json) {
    this.idFavorito = json["idFavorito"];
    this.idUsuario = json["idUsuario"];
    this.idReceta = json["idReceta"];
  }
}
