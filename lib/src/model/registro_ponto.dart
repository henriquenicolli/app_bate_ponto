import 'package:flutter/material.dart';

class RegistroPonto {
  DateTime dataMarcacaoPonto;
  TimeOfDay horaMarcacaoPonto;
  String tipoMarcacao;

  RegistroPonto(
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

  String get getTipoMarcacao {
    return tipoMarcacao == 'E' ? 'Entrada' : 'Saída';
  }

  set setDataMarcacaoPonto(DateTime newDataMarcacaoPonto) {
    this.dataMarcacaoPonto = newDataMarcacaoPonto;
  }

  set setHoraMarcacaoPonto(TimeOfDay newHoraMarcacaoPonto) {
    this.horaMarcacaoPonto = newHoraMarcacaoPonto;
  }

  set setTipoMarcacao(String newTipoMarcacao) {
    this.tipoMarcacao = newTipoMarcacao;
  }
}
