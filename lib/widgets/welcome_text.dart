import 'package:flutter/material.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  String _getDayOfWeek(int weekday) {
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

  String _getMonthName(int month) {
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

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String day = now.day.toString();
    String dayOfWeekName = _getDayOfWeek(now.weekday + 1);
    String monthName = _getMonthName(now.month);

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Bom dia, Henrique',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '$dayOfWeekName, $day de $monthName',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          //const FavoriteWidget(),
        ],
      ),
    );
  }
}
