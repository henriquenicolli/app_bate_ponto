import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/enums/tipo_marcacao.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';
import '../../../services/api_request_service.dart';

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
            subtitle: Text('Sem apontamento'),
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
                    if (registroSelecionado.registroAlterado && !registroSelecionado.registroAlteradoAprovacao)
                      Row(
                        children: [
                          Icon(Icons.warning, color: Colors.orangeAccent),
                          Text('Pendente de aprovação', style: TextStyle(color: Colors.orangeAccent)),
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

TimeOfDay parseTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
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

  return groupedItems.values.toList();
}
