class Dificultad {
  Dificultad(int idDificultad, String dificultad);

  int idDificultad;
  String dificultad;

  Dificultad.fromJson(Map json) {
    this.idDificultad = json["idDificultad"];
    this.dificultad = json["dificultad"];
  }
}
