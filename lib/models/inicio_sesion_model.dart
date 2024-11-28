class InicioSesionModel {
  // Atributos
  String email;
  String password;

  // Constructor
  InicioSesionModel({required this.email, required this.password});

  // Método para convertir los atributos de la clase a un mapa
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Método para retornar una nueva instancia de la clase
  factory InicioSesionModel.fromJson(Map<String, dynamic> json) {
    return InicioSesionModel(
      email: json['email'],
      password: json['password'],
    );
  }
}
