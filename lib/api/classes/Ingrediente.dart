class Ingrediente {
  Ingrediente(int idIngrediente, int idTipoIngrediente, String ingrediente);

  int idIngrediente;
  int idTipoIngrediente;
  String ingrediente;

  Ingrediente.fromJson(Map json) {
    this.idIngrediente = json["idIngrediente"];
    this.idTipoIngrediente = json["idTipoIngrediente"];
    this.ingrediente = json["ingrediente"];
  }
}
