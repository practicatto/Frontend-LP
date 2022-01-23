import 'dart:convert';

class Abogado {
  int id;
  String correo;
  String nombre;
  String descripcion;
  String experiencia;
  int calificacion;

  Abogado(this.id, this.correo, this.nombre, this.descripcion, this.experiencia,
      this.calificacion);


  Abogado copyWith({
    int? id,
    String? correo,
    String? nombre,
    String? descripcion,
    String? experiencia,
    int? calificacion,
  }) {
    return Abogado(
      id ?? this.id,
      correo ?? this.correo,
      nombre ?? this.nombre,
      descripcion ?? this.descripcion,
      experiencia ?? this.experiencia,
      calificacion ?? this.calificacion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'correo': correo,
      'nombre': nombre,
      'descripcion': descripcion,
      'experiencia': experiencia,
      'calificacion': calificacion,
    };
  }

  factory Abogado.fromMap(Map<String, dynamic> map) {
    return Abogado(
      map['id']?.toInt() ?? 0,
      map['correo'] ?? '',
      map['nombre'] ?? '',
      map['descripcion'] ?? '',
      map['experiencia'] ?? '',
      map['calificacion']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Abogado.fromJson(String source) => Abogado.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Abogado(id: $id, correo: $correo, nombre: $nombre, descripcion: $descripcion, experiencia: $experiencia, calificacion: $calificacion)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Abogado &&
      other.id == id &&
      other.correo == correo &&
      other.nombre == nombre &&
      other.descripcion == descripcion &&
      other.experiencia == experiencia &&
      other.calificacion == calificacion;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      correo.hashCode ^
      nombre.hashCode ^
      descripcion.hashCode ^
      experiencia.hashCode ^
      calificacion.hashCode;
  }
}
