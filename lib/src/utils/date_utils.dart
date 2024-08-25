import 'package:flutter/material.dart';

String getDayOfWeek(int weekday) {
  switch (weekday) {
    case 1:
      return 'Segunda-feira';
    case 2:
      return 'Terça-feira';
    case 3:
      return 'Quarta-feira';
    case 4:
      return 'Quinta-feira';
    case 5:
      return 'Sexta-feira';
    case 6:
      return 'Sábado';
    case 7:
      return 'Domingo';
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
String formatHoraAtualHHmmSS() {
  final DateTime now = DateTime.now();
  return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
}

///
/// Retorna a data atual formato "DD-MM-AAAA"
///
String formatDateTimeDDmmAAAA(DateTime dateTime) {
  return '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}';
}

///
/// Retorna a data atual formato "AAAA-MM-DD"
///
String formatDateTimeAAAAmmDD(DateTime selectedDate) => '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';

///
/// Retorna a hora atual no formato "HH:MM:SS"
///
String formatTimeOfDayHHmmSS(TimeOfDay selectedTime) => '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00';



///
/// Recebe uma string no formato de tempo (por exemplo, "12:30") e a converte em um objeto TimeOfDay.
///
TimeOfDay parseTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}