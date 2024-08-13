import 'package:flutter/material.dart';

String getDayOfWeek(int weekday) {
  switch (weekday) {
    case 1:
      return 'Domingo';
    case 2:
      return 'Segunda-feira';
    case 3:
      return 'Terça-feira';
    case 4:
      return 'Quarta-feira';
    case 5:
      return 'Quinta-feira';
    case 6:
      return 'Sexta-feira';
    case 7:
      return 'Sábado';
    default:
      return '';
  }
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'Janeiro';
    case 2:
      return 'Fevereiro';
    case 3:
      return 'Março';
    case 4:
      return 'Abril';
    case 5:
      return 'Maio';
    case 6:
      return 'Junho';
    case 7:
      return 'Julho';
    case 8:
      return 'Agosto';
    case 9:
      return 'Setembro';
    case 10:
      return 'Outubro';
    case 11:
      return 'Novembro';
    case 12:
      return 'Dezembro';
    default:
      return '';
  }
}

///
/// Retorna a data atual formato "AAAA-MM-DD"
///
String getDataAtualFormatada() {
  final DateTime now = DateTime.now();
  return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
}

///
/// Retorna a hora atual no formato "HH:MM:SS"
///
String getHoraAtualFormatada() {
  final DateTime now = DateTime.now();
  return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
}

///
/// Retorna a data atual formato "AAAA-MM-DD"
///
String getHoraFormatadaFromDateTime(DateTime selectedDate) => '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';

///
/// Retorna a hora atual no formato "HH:MM:SS"
///
String getHoraFormatadaFromTimeOfDay(TimeOfDay selectedTime) => '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00';

