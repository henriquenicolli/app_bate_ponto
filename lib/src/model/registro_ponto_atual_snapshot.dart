import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';

class RegistroPontoAtualSnapshot {
  final List<RegistroPonto> registroPontoHojeList;
  final List<RegistroPonto> registroPontoOntemList;
  final TimeOfDay horasTrabalhadasHoje;
  final TimeOfDay horasTrabalhadasOntem;
  final TimeOfDay horasExtrasMes;
  final TimeOfDay horasCompensaveisMes;

  const RegistroPontoAtualSnapshot(
      {required this.registroPontoHojeList,
      required this.registroPontoOntemList,
      required this.horasTrabalhadasHoje,
      required this.horasTrabalhadasOntem,
      required this.horasExtrasMes,
      required this.horasCompensaveisMes});

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
      horasCompensaveisMes: parseTimeOfDay(json['horasCompensaveisMes']),
    );
  }
}
