import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/utils/date_utils.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String day = now.day.toString();
    String dayOfWeekName = getDayOfWeek(now.weekday);
    String monthName = getMonthName(now.month);

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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: AppLayoutDefaults.fontFamily),
                  ),
                ),
                Text(
                  '$dayOfWeekName, $day de $monthName',
                  style: TextStyle(color: Colors.grey[500], fontSize: 20, fontFamily: AppLayoutDefaults.fontFamily),
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
