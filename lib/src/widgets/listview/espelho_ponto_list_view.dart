import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';

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
          // Resto do código...
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Resto do código...
                Column(
                  children: itemsByDate.map((registroSelecionado) {
                    final TextEditingController _controller =
                        TextEditingController(
                            text: registroSelecionado.horaFormatada);
                    return Column(
                      children: [
                        ListTile(
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
                                          registroSelecionado:
                                              registroSelecionado,
                                          onUpdate: () {
                                            setState(() {});
                                          });
                                    },
                                  );
                                },
                              ),
                            ],
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

/*  void showEditarHoraDialog(BuildContext context,
      TextEditingController _controller, RegistroPonto registroSelecionado) {}*/
}

class EditarRegistroPontoDialog extends StatefulWidget {
  final RegistroPonto registroSelecionado;
  final Function() onUpdate;

  EditarRegistroPontoDialog(
      {Key? key, required this.registroSelecionado, required this.onUpdate})
      : super(key: key);

  @override
  _EditarRegistroPontoDialogState createState() =>
      _EditarRegistroPontoDialogState();
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
                items: <String>['E', 'S']
                    .map<DropdownMenuItem<String>>((String value) {
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

            print(widget.registroSelecionado.horaFormatada);
            print(widget.registroSelecionado.tipoMarcacao);
            print(widget.registroSelecionado.empregado);
            widget.onUpdate();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
