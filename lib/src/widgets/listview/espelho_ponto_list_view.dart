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
      if (groupedItems.containsKey(date)) {
        groupedItems[date]!.add(item);
      } else {
        groupedItems[date] = [item];
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat('dd/MM/yyyy')
                      .format(itemsByDate.first.dataHoraRegistroPonto),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Column(
                children: itemsByDate.map((item) {
                  return ListTile(
                    title: Text(
                      '${item.dataHoraRegistroPonto} ${item.tipoRegistro}',
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
