import 'dart:convert';

class Categoria {
  int id;
  String nombre;
  String descripcion;

  Categoria(this.id, this.nombre, this.descripcion);

  Categoria copyWith({
    required int id,
    required String nombre,
    required String descripcion,
  }) {
    return Categoria(id, nombre, descripcion);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'nombre': nombre, 'descripcion': descripcion};
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      map['id']?.toInt() ?? 0,
      map['nombre'] ?? '',
      map['descripcion'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Categoria.fromJson(String source) =>
      Categoria.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Categoria(id: $id, nombre: $nombre, descripcion: $descripcion)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Categoria &&
        other.id == id &&
        other.nombre == nombre &&
        other.descripcion == descripcion;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nombre.hashCode ^ descripcion.hashCode;
  }
}
