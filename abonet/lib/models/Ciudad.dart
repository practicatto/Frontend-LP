import 'dart:convert';

class Ciudad {
  int id;
  String nombre;

  Ciudad(this.id, this.nombre);

  Ciudad copyWith({
    required int id,
    required String nombre,
  }) {
    return Ciudad(
      id,
      nombre,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  factory Ciudad.fromMap(Map<String, dynamic> map) {
    return Ciudad(
      map['id']?.toInt() ?? 0,
      map['nombre'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Ciudad.fromJson(String source) => Ciudad.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ciudad(id: $id, nombre: $nombre,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ciudad && other.id == id && other.nombre == nombre;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nombre.hashCode;
  }
}
