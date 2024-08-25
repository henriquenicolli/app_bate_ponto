import 'package:flutter/material.dart';

import '../../../model/enums/tipo_marcacao.dart';
import '../../../model/registro_ponto.dart';
import '../../../services/api_request_service.dart';
import '../../../utils/date_utils.dart';

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

  Future<int> _atualizarPonto(RegistroPonto registroPonto, BuildContext context) async {
    int? response = await ApiRequestService().atualizarRegistroPonto(registroPonto);

    if (response == 200 || response == 202) {
      return 1;
    } else {
      return -1;
    }
  }

  void atualizaRegistroPontoSelecionado(String horaSelecionada, String tipoMarcacao) {
    widget.registroSelecionado.setTipoMarcacao = tipoMarcacao;
    widget.registroSelecionado.setHoraMarcacaoPonto = parseTimeOfDay(horaSelecionada);
    widget.registroSelecionado.registroAlterado = true;
    widget.registroSelecionado.registroAlteradoAprovacao = false;
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
                      atualizaRegistroPontoSelecionado(horaSelecionada, widget.registroSelecionado.getTipoMarcacao);
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
                      atualizaRegistroPontoSelecionado(widget.registroSelecionado.horaFormatada, tipoMarcacao);
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
}