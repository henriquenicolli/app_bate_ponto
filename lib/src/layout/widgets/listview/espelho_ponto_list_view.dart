import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/enums/tipo_marcacao.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';
import '../../../services/api_request_service.dart';
import '../../../utils/date_utils.dart';

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
                      width: 120,
                      child: Text(
                        '${registroSelecionado.horaFormatada} ${registroSelecionado.getTipoMarcacao}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (registroSelecionado.registroAlterado && !registroSelecionado.registroAlteradoAprovacao)
                       Row(
                          children: [
                            Icon(Icons.warning, color: Colors.orangeAccent),
                            Text('Pendente de aprovação', style: TextStyle(color: Colors.orangeAccent, fontSize: 10)),
                            // Texto ao lado do ícone
                          ],
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
                              },
                              parentContext: context,
                            );
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

  Future<void> verificaApontamentoRegistro(List<RegistroPonto> itemsByDate) async {
    int countE = 0;
    int countS = 0;
    DateTime currentDate = DateTime.now();

    for (var item in itemsByDate) {
      if (item.registroAlterado && !item.registroAlteradoAprovacao) {
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

}

///
/// Componente [EditarRegistroPontoDialog] Dialog por editar um Registro de Ponto
///
class EditarRegistroPontoDialog extends StatefulWidget {
  final RegistroPonto registroSelecionado;
  final Function() onUpdate;
  final BuildContext parentContext;

  EditarRegistroPontoDialog(
      {Key? key, required this.registroSelecionado, required this.onUpdate, required this.parentContext})
      : super(key: key);

  @override
  _EditarRegistroPontoDialogState createState() => _EditarRegistroPontoDialogState();
}

class _EditarRegistroPontoDialogState extends State<EditarRegistroPontoDialog> {
  final TextEditingController _controller = TextEditingController();
  Future<int>? _future;

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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (String? horaSelecionada) {
                  setState(() {
                    if (horaSelecionada != null) {
                      widget.registroSelecionado.setHoraMarcacaoPonto = parseTimeOfDay(horaSelecionada);
                      widget.registroSelecionado.registroAlterado = true;
                      widget.registroSelecionado.registroAlteradoAprovacao = false;
                    }
                  });
                },
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Hora',
                ),
              ),
              DropdownButton<String>(
                value: widget.registroSelecionado.getTipoMarcacao,
                onChanged: (String? tipoMarcacao) {
                  if (tipoMarcacao != null) {
                    setState(() {
                      widget.registroSelecionado.setTipoMarcacao = tipoMarcacao;
                      widget.registroSelecionado.registroAlterado = true;
                      widget.registroSelecionado.registroAlteradoAprovacao = false;
                    });
                  }
                },
                items: <String>[TipoMarcacao.ENTRADA.descricao, TipoMarcacao.SAIDA.descricao]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              if (_future != null)
                FutureBuilder<int>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return mostraCirularProgressIndicator();
                      } else {
                        if (snapshot.hasError || snapshot.data == -1) {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            mostraDialogErroRegistroPonto();
                          });
                        } else {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            mostraDialogRegistradoSucesso();
                          });
                        }
                      }
                      return Container();
                    }),
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
            setState(() {
              _future = _atualizarPonto(widget.registroSelecionado, context);
              widget.onUpdate();
            });

            //Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void mostraDialogRegistradoSucesso() {
    showDialog(
      context: widget.parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Solicitacao de alteracao de ponto enviada!'),
          actions: [
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void mostraDialogErroRegistroPonto() {
    showDialog(
      context: widget.parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Erro ao atualizar ponto',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Servico indisponivel. Por favor, tente novamente.',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Center mostraCirularProgressIndicator() {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

Future<int> _atualizarPonto(RegistroPonto registroPonto, BuildContext context) async {
  int? response = await ApiRequestService().atualizarRegistroPonto(registroPonto);

  if (response == 200 || response == 202) {
    return 1;
  } else {
    return -1;
  }
}


///
/// Agrupa os registros de ponto por data
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
  }

  groupItensByHour(groupedItems);

  var sortedGroupedItems = groupedItems.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));

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
