import 'package:flutter/material.dart';

class RegistroPonto {
  final DateTime dataMarcacaoPonto;
  final TimeOfDay horaMarcacaoPonto;
  final String tipoMarcacao;

  const RegistroPonto(
      {required this.dataMarcacaoPonto,
      required this.horaMarcacaoPonto,
      required this.tipoMarcacao});

  factory RegistroPonto.fromJson(Map<String, dynamic> json) {
    TimeOfDay parseTimeOfDay(String timeString) {
      final parts = timeString.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    if (json['dataMarcacaoPonto'] is String) {
      return RegistroPonto(
        dataMarcacaoPonto: DateTime.parse(json['dataMarcacaoPonto']),
        horaMarcacaoPonto: parseTimeOfDay(json['horaMarcacaoPonto']),
        tipoMarcacao: json['tipoMarcacao'].toString(),
      );
    } else {
      throw const FormatException('Failed to parse registro ponto');
    }
  }

  String get horaFormatada {
    return '${horaMarcacaoPonto.hour.toString().padLeft(2, '0')}:${horaMarcacaoPonto.minute.toString().padLeft(2, '0')}';
  }
}
