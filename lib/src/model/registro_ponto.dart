import 'package:flutter/material.dart';

class RegistroPonto {
  int numSeqRegistro;
  int numSeqEsRegistro;
  DateTime dataMarcacaoPonto;
  TimeOfDay horaMarcacaoPonto;
  String fusoHorarioMarcacao;
  String fusoHorarioRegistro;
  bool marcacaoOnline;
  String cpfFuncionario;
  double latitude;
  double longitude;
  String motivoMarcacao;
  int coletorRegistro;
  String tipoMarcacao;
  String fonteMarcacao;
  String empregado;

  RegistroPonto({
    required this.numSeqRegistro,
    required this.numSeqEsRegistro,
    required this.dataMarcacaoPonto,
    required this.horaMarcacaoPonto,
    required this.fusoHorarioMarcacao,
    required this.fusoHorarioRegistro,
    required this.marcacaoOnline,
    required this.cpfFuncionario,
    required this.latitude,
    required this.longitude,
    required this.motivoMarcacao,
    required this.coletorRegistro,
    required this.tipoMarcacao,
    required this.fonteMarcacao,
    required this.empregado});

  factory RegistroPonto.fromJson(Map<String, dynamic> json) {
    TimeOfDay parseTimeOfDay(String timeString) {
      final parts = timeString.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    if (json['dataMarcacaoPonto'] is String) {
      return RegistroPonto(
        numSeqRegistro: json['numSeqRegistro'],
        numSeqEsRegistro: json['numSeqEsRegistro'],
        dataMarcacaoPonto: DateTime.parse(json['dataMarcacaoPonto']),
        horaMarcacaoPonto: parseTimeOfDay(json['horaMarcacaoPonto']),
        fusoHorarioMarcacao: json['fusoHorarioMarcacao'],
        fusoHorarioRegistro: json['fusoHorarioRegistro'],
        marcacaoOnline: json['marcacaoOnline'],
        cpfFuncionario: json['cpfFuncionario'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        motivoMarcacao: json['motivoMarcacao'],
        coletorRegistro: json['coletorRegistro'],
        tipoMarcacao: json['tipoMarcacao'],
        fonteMarcacao: json['fonteMarcacao'],
        empregado: json['empregado'],
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
