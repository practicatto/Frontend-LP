import 'dart:convert';

class Comentario {
  int id;
  String mensaje;
  double calificacion;
  int idUser;

  Comentario(this.id, this.mensaje, this.calificacion, this.idUser);

  Comentario copyWith(
      {required int id,
      required String mensaje,
      required double calificacion,
      required int idUser}) {
    return Comentario(id, mensaje, calificacion, idUser);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'mensaje': mensaje, 'calificacion': calificacion};
  }

  factory Comentario.fromMap(Map<String, dynamic> map) {
    return Comentario(map['id']?.toInt() ?? 0, map['mensaje'] ?? '',
        map['calificacion']?.toDouble() ?? '', map['usuarioId']?.toInt() ?? 0);
  }

  String toJson() => json.encode(toMap());

  factory Comentario.fromJson(String source) =>
      Comentario.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comentario(id: $id, mensaje: $mensaje, calificacion: $calificacion)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comentario &&
        other.id == id &&
        other.mensaje == mensaje &&
        other.calificacion == calificacion;
  }

  @override
  int get hashCode {
    return id.hashCode ^ mensaje.hashCode ^ calificacion.hashCode;
  }
}
