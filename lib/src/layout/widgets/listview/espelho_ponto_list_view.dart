import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/layout/widgets/dialog/deletar_registro_ponto_dialog.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';
import '../../../utils/date_utils.dart';
import '../dialog/editar_registro_ponto_dialog.dart';

///
/// Componente [EspelhoPontoListView] ListView que exibe o espelho de ponto
///
class EspelhoPontoListView extends StatefulWidget {
  final List<RegistroPonto> items;

  EspelhoPontoListView({Key? key, required this.items}) : super(key: key);

  @override
  State<EspelhoPontoListView> createState() => _EspelhoPontoListViewState();
}

class _EspelhoPontoListViewState extends State<EspelhoPontoListView> {
  late Color containerColor = Colors.green;
  late String displayText = "Sem apontamento";

  @override
  void initState() {
    super.initState();
  }

  Future<void> verificaApontamentoRegistro(List<RegistroPonto> itemsByDate) async {
    int countE = 0;
    int countS = 0;
    DateTime currentDate = DateTime.now();

    for (var item in itemsByDate) {
      if ((item.registroAlterado && !item.registroAlteradoAprovacao) ||
          (item.registroExcluido && !item.registroExcluidoAprovacao)) {
        containerColor = Colors.orangeAccent;
        displayText = 'Pendente de aprovação';
        return;
      } else if (item.tipoMarcacao == 'E') {
        countE++;
      } else if (item.tipoMarcacao == 'S') {
        countS++;
      }
    }
    if (countE != countS && itemsByDate[0].dataMarcacaoPonto.day != currentDate.day) {
      containerColor = Colors.red;
      displayText = 'Inconsistência de marcação';
    } else {
      containerColor = Colors.green;
      displayText = 'Sem apontamento';
    }
  }

  ///
  /// Agrupa os registros de ponto por data e trata a exibicao
  ///
  List<List<RegistroPonto>> groupItemsByDate(List<RegistroPonto> items) {
    Map<DateTime, List<RegistroPonto>> groupedItems = {};

    for (var item in items) {
      DateTime date = item.dataMarcacaoPonto;
      DateTime dateOnly = DateTime(date.year, date.month, date.day);
      if (groupedItems.containsKey(dateOnly)) {
        groupedItems[dateOnly]!.add(item);
      } else {
        groupedItems[dateOnly] = [item];
      }

      if (item.registroExcluido && item.registroExcluidoAprovacao) {
        groupedItems[dateOnly]!.remove(item);
      }
    }

    groupItensByHour(groupedItems);
    var sortedGroupedItems = groupedItems.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    return sortedGroupedItems.map((e) => e.value).toList();
  }

  ///
  /// Agrupa os registros de ponto hora
  ///
  void groupItensByHour(Map<DateTime, List<RegistroPonto>> groupedItems) {
    for (var key in groupedItems.keys) {
      groupedItems[key]!.sort((a, b) {
        final aTime = a.horaMarcacaoPonto;
        final bTime = b.horaMarcacaoPonto;
        if (aTime.hour != bTime.hour) {
          return aTime.hour.compareTo(bTime.hour);
        } else {
          return aTime.minute.compareTo(bTime.minute);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<RegistroPonto>> groupedItems = groupItemsByDate(widget.items);

    return ListView.builder(
      itemCount: groupedItems.length,
      itemBuilder: (context, index) {
        List<RegistroPonto> itemsByDate = groupedItems[index];
        verificaApontamentoRegistro(itemsByDate);
        return Card(
          child: ExpansionTile(
            title: Text('Data: ${formatDateTimeDDmmAAAA(itemsByDate[0].dataMarcacaoPonto)}'),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    displayText,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            children: itemsByDate.map((registroSelecionado) {
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        '${registroSelecionado.horaFormatada} ${registroSelecionado.getTipoMarcacao}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (registroSelecionado.registroAlterado && !registroSelecionado.registroAlteradoAprovacao)
                      const Row(
                        children: [
                          Icon(Icons.edit_calendar, color: Colors.orangeAccent),
                          Text('Pendente de aprovação', style: TextStyle(color: Colors.orangeAccent, fontSize: 10)),
                          // Texto ao lado do ícone
                        ],
                      ),

                    if (registroSelecionado.registroExcluido && !registroSelecionado.registroExcluidoAprovacao)
                      const Row(
                        children: [
                          Icon(Icons.delete, color: Colors.orangeAccent),
                          Text('Pendente de aprovacao', style: TextStyle(color: Colors.orangeAccent, fontSize: 10)),
                          // Texto ao lado do ícone
                        ],
                      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EditarRegistroPontoDialog(
                                  registroSelecionado: registroSelecionado,
                                  onUpdate: () {
                                    setState(() {});
                                  },
                                  parentContext: context,
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DeletarRegistroPontoDialog(
                                  registroSelecionado: registroSelecionado,
                                  onUpdate: () {
                                    setState(() {});
                                  },
                                  parentContext: context,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
