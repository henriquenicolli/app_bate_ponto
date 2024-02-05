import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/configuration/app_colors.dart';
import '../widgets/listview/espelho_ponto_list_view.dart';

class EspelhoPonto extends StatelessWidget {
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  EspelhoPonto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.timelapse,
            color: AppColors.secondaryColor,
          ),
        ),
        Text(
          'Espelho de ponto',
          style: TextStyle(
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor),
        ),
      ])),
      body:
          //MySelector(),
          EspelhoPontoListView(items: items),
    );
  }
}
