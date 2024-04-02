import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';

class RegistroPontoAtualSnapshot {
  final List<RegistroPonto> registroPontoHojeList;
  final List<RegistroPonto> registroPontoOntemList;
  final TimeOfDay horasTrabalhadasHoje;
  final TimeOfDay horasTrabalhadasOntem;
  final TimeOfDay horasExtrasMes;
  final TimeOfDay horasExtrasHoje;

  const RegistroPontoAtualSnapshot(
      {required this.registroPontoHojeList,
      required this.registroPontoOntemList,
      required this.horasTrabalhadasHoje,
      required this.horasTrabalhadasOntem,
      required this.horasExtrasMes,
      required this.horasExtrasHoje});

  String get formattedHorasTrabalhadasHoje {
    return '${horasTrabalhadasHoje.hour.toString().padLeft(2, '0')}:${horasTrabalhadasHoje.minute.toString().padLeft(2, '0')}';
  }

  String get formattedHorasTrabalhadasOntyem {
    return '${horasTrabalhadasOntem.hour.toString().padLeft(2, '0')}:${horasTrabalhadasOntem.minute.toString().padLeft(2, '0')}';
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
      horasTrabalhadasHoje: parseTimeOfDay(json['horasTrabalhadasHoje']),
      horasTrabalhadasOntem: parseTimeOfDay(json['horasTrabalhadasOntem']),
      horasExtrasMes: parseTimeOfDay(json['horasExtrasMes']),
      horasExtrasHoje: parseTimeOfDay(json['horasExtrasHoje']),
    );
  }
}
