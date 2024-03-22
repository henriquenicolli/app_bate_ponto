import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';
import 'package:intl/intl.dart';

class EspelhoPontoListView extends StatelessWidget {
  final List<RegistroPonto> items;

  EspelhoPontoListView({Key? key, required this.items}) : super(key: key);

  List<List<RegistroPonto>> groupItemsByDate(List<RegistroPonto> items) {
    Map<DateTime, List<RegistroPonto>> groupedItems = {};

    for (var item in items) {
      DateTime date = item.dataHoraRegistroPonto;
      DateTime dateOnly = DateTime(date.year, date.month, date.day);
      if (groupedItems.containsKey(dateOnly)) {
        groupedItems[dateOnly]!.add(item);
      } else {
        groupedItems[dateOnly] = [item];
      }
    }

    return groupedItems.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    List<List<RegistroPonto>> groupedItems = groupItemsByDate(items);

    return ListView.builder(
      itemCount: groupedItems.length,
      itemBuilder: (context, index) {
        List<RegistroPonto> itemsByDate = groupedItems[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(itemsByDate.first.dataHoraRegistroPonto),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  children: itemsByDate.map((item) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            '${item.horaFormatada} ${item.tipoRegistro}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
