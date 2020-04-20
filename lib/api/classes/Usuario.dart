class Usuario {
  Usuario(int id, String nombre, String pass, String email);

  int id;
  String nombre;
  String pass;
  String email;

  Usuario.fromJson(Map json) {
    this.id = json['id'];
    this.nombre = json['nombre'];
    this.pass = json['pass'];
    this.email = json['email'];
  }
}
