import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';

class RegistroPontoAtualSnapshot {
  final List<RegistroPonto> registroPontoHojeList;
  final List<RegistroPonto> registroPontoOntemList;
  List<RegistroPonto> registroPontoSelecionadoList;
  final TimeOfDay horasTrabalhadasHoje;
  final TimeOfDay horasTrabalhadasOntem;
  TimeOfDay horasTrabalhadasSelecionado;
  final TimeOfDay horasExtrasMes;
  final TimeOfDay horasExtrasHoje;

  RegistroPontoAtualSnapshot(
      {required this.registroPontoHojeList,
      required this.registroPontoOntemList,
      required this.registroPontoSelecionadoList,
      required this.horasTrabalhadasHoje,
      required this.horasTrabalhadasOntem,
      required this.horasTrabalhadasSelecionado,
      required this.horasExtrasMes,
      required this.horasExtrasHoje});

  set setRegistroPontoSelecionadoList(List<RegistroPonto> value) {
    registroPontoSelecionadoList = value;
  }

  set sethorasTrabalhadasSelecionado(TimeOfDay value) {
    horasTrabalhadasSelecionado = value;
  }

  /*String get formattedHorasTrabalhadasHoje {
    return '${horasTrabalhadasHoje.hour.toString().padLeft(2, '0')}:${horasTrabalhadasHoje.minute.toString().padLeft(2, '0')}';
  }

  String get formattedHorasTrabalhadasOntyem {
    return '${horasTrabalhadasOntem.hour.toString().padLeft(2, '0')}:${horasTrabalhadasOntem.minute.toString().padLeft(2, '0')}';
  }*/

  String get formattedHorasTrabalhadas {
    return '${horasTrabalhadasSelecionado.hour.toString().padLeft(2, '0')}:${horasTrabalhadasSelecionado.minute.toString().padLeft(2, '0')}';
  }

  String get formattedhorasExtrasMes {
    return '${horasExtrasMes.hour.toString().padLeft(2, '0')}:${horasExtrasMes.minute.toString().padLeft(2, '0')}';
  }

  String get formattedCompensaveisMes {
    return '${horasExtrasHoje.hour.toString().padLeft(2, '0')}:${horasExtrasHoje.minute.toString().padLeft(2, '0')}';
  }

  factory RegistroPontoAtualSnapshot.fromJson(Map<String, dynamic> json) {
    TimeOfDay parseTimeOfDay(String timeString) {
      final parts = timeString.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    List<RegistroPonto> parseRegistroPontoList(List<dynamic> jsonList) {
      return jsonList.map((item) => RegistroPonto.fromJson(item)).toList();
    }

    return RegistroPontoAtualSnapshot(
      registroPontoHojeList:
          parseRegistroPontoList(json['registroPontoHojeList']),
      registroPontoOntemList:
          parseRegistroPontoList(json['registroPontoOntemList']),
      registroPontoSelecionadoList:
          parseRegistroPontoList(json['registroPontoHojeList']),
      horasTrabalhadasHoje: parseTimeOfDay(json['horasTrabalhadasHoje']),
      horasTrabalhadasOntem: parseTimeOfDay(json['horasTrabalhadasOntem']),
      horasTrabalhadasSelecionado: parseTimeOfDay(json['horasTrabalhadasHoje']),
      horasExtrasMes: parseTimeOfDay(json['horasExtrasMes']),
      horasExtrasHoje: parseTimeOfDay(json['horasExtrasHoje']),
    );
  }
}
