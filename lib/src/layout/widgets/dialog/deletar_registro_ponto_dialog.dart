import 'package:flutter/material.dart';

import '../../../model/enums/tipo_marcacao.dart';
import '../../../model/registro_ponto.dart';
import '../../../services/api_request_service.dart';
import '../../../utils/date_utils.dart';

///
/// Componente [DeletarRegistroPontoDialog] Dialog por editar um Registro de Ponto
///
class DeletarRegistroPontoDialog extends StatefulWidget {
  final RegistroPonto registroSelecionado;
  final Function() onUpdate;
  final BuildContext parentContext;

  DeletarRegistroPontoDialog(
      {Key? key, required this.registroSelecionado, required this.onUpdate, required this.parentContext})
      : super(key: key);

  @override
  _DeletarRegistroPontoDialogState createState() => _DeletarRegistroPontoDialogState();
}

class _DeletarRegistroPontoDialogState extends State<DeletarRegistroPontoDialog> {
  final TextEditingController _controller = TextEditingController();
  Future<int>? _future;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.registroSelecionado.horaFormatada;
  }

  Future<int> _deletarRegistroPonto(RegistroPonto registroPonto, BuildContext context) async {
    int? response = await ApiRequestService().deletarRegistroPonto(registroPonto);

    if (response == 200 || response == 202) {
      return 1;
    } else {
      return -1;
    }
  }

  /*void atualizaRegistroPontoSelecionado(String horaSelecionada, String tipoMarcacao) {
    //widget.registroSelecionado.registroExcluido = true;
    //widget.registroSelecionado.registroAlteradoAprovacao = false;
  }*/

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
            'Erro ao enviar solicitacao de delecao ponto',
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

  void mostraDialogSolicitacaoSucesso() {
    showDialog(
      context: widget.parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Solicitacao de delecao de ponto enviada!'),
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
      title: Text('Solicitar exclusao de ponto'),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'Deseja solicitar a exclusao do ponto?',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
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
                            mostraDialogSolicitacaoSucesso();
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
          child: Text('Deletar'),
          onPressed: () {
            setState(() {
              _future = _deletarRegistroPonto(widget.registroSelecionado, context);
              widget.onUpdate();
            });

            //Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}