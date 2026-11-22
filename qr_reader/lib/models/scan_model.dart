import 'package:latlong2/latlong.dart';

class ScanModel {
  int? id;
  String? tipo;
  String valor;

  ScanModel({this.id, this.tipo, required this.valor}) {
    if (valor.contains('http')) {
      tipo = 'http';
    } else {
      tipo = 'geo';
    }
  }

  // De Map (BD) a objeto
  factory ScanModel.fromJson(Map<String, dynamic> json) =>
      ScanModel(id: json["id"], tipo: json["tipo"], valor: json["valor"]);

  // De objeto a Map (para insertar/actualizar en la BD)
  Map<String, dynamic> toJson() => {"id": id, "tipo": tipo, "valor": valor};

  // Para el mapa: de 'geo:15.33,15.66' a LatLng
  LatLng getLatLng() {
    final latLng = valor.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);
    return LatLng(lat, lng);
  }
}
