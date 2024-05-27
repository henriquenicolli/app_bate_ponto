import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';

import '../../configuration/app_layout_defaults.dart';
import '../../services/api_request_service.dart';

class EspelhoPontoListView extends StatefulWidget {
  final List<RegistroPonto> items;

  EspelhoPontoListView({Key? key, required this.items}) : super(key: key);

  @override
  State<EspelhoPontoListView> createState() => _EspelhoPontoListViewState();
}

class _EspelhoPontoListViewState extends State<EspelhoPontoListView> {
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
    }

    return groupedItems.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    List<List<RegistroPonto>> groupedItems = groupItemsByDate(widget.items);

    return ListView.builder(
      itemCount: groupedItems.length,
      itemBuilder: (context, index) {
        List<RegistroPonto> itemsByDate = groupedItems[index];
        return Card(
          child: ExpansionTile(
            title: Text('Data: ${itemsByDate[0].dataMarcacaoPonto}'),
            children: itemsByDate.map((registroSelecionado) {
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${registroSelecionado.horaFormatada} ${registroSelecionado.getTipoMarcacao}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
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
                                });
                          },
                        );
                      },
                    ),
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

class EditarRegistroPontoDialog extends StatefulWidget {
  final RegistroPonto registroSelecionado;
  final Function() onUpdate;

  EditarRegistroPontoDialog({Key? key, required this.registroSelecionado, required this.onUpdate}) : super(key: key);

  @override
  _EditarRegistroPontoDialogState createState() => _EditarRegistroPontoDialogState();
}

class _EditarRegistroPontoDialogState extends State<EditarRegistroPontoDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.registroSelecionado.horaFormatada;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar item'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.4,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (String? value) {
                  setState(() {
                    if (value != null) {
                      widget.registroSelecionado.setHoraMarcacaoPonto = parseTimeOfDay(value);
                    }
                  });
                },
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Hora',
                ),
              ),
              DropdownButton<String>(
                value: widget.registroSelecionado.tipoMarcacao,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      widget.registroSelecionado.setTipoMarcacao = newValue;
                    });
                  }
                },
                items: <String>['E', 'S'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Salvar'),
          onPressed: () {
            // Coloque aqui a lógica para salvar as alterações

            widget.onUpdate();
            atualizarPonto(widget.registroSelecionado, context);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

void atualizarPonto(RegistroPonto registroPonto, BuildContext context) async {
  int response = await ApiRequestService().atualizarRegistroPonto(registroPonto);

  if (response == 200 || response == 202) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ponto registrado com sucesso'),
        backgroundColor: AppLayoutDefaults.sucessColor,
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Erro durante registro de ponto'),
        backgroundColor: AppLayoutDefaults.errorColor,
      ),
    );
  }
}

TimeOfDay parseTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}
