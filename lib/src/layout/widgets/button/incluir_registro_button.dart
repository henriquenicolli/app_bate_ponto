import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:location/location.dart';

import '../../../model/enums/tipo_marcacao.dart';
import 'package:flutter_app_bate_ponto/src/services/api_request_service.dart';

import '../../../utils/date_utils.dart';

LocationData currentLocation = LocationData.fromMap({
  'latitude': -23.5505,
  'longitude': -46.6333,
});

TipoMarcacao? tipoMarcacao = TipoMarcacao.ENTRADA;
const String fusoHorarioMarcacao = "GMT-3";


///
/// Classe [IncluirRegistroButton], componente do botão IncluirRegistroButton que ao ser clicado exibe um dialogo
/// para permitir a inclusao de um registro de ponto
///
class IncluirRegistroButton extends StatelessWidget {
  const IncluirRegistroButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.0),
      child: SizedBox(
        width: 300,
        height: 70,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return IncluirPontoCallDialog(parentContext: context);
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppLayoutDefaults.secondaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Incluir Registro',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

///
/// Classe [IncluirPontoCallDialog], componente que exibe um dialog com a opcao de realizar um registro de ponto
///
class IncluirPontoCallDialog extends StatefulWidget {
  final BuildContext parentContext;

  const IncluirPontoCallDialog({Key? key, required this.parentContext}) : super(key: key);

  @override
  State<IncluirPontoCallDialog> createState() => _IncluirPontoCallDialogState();
}

class _IncluirPontoCallDialogState extends State<IncluirPontoCallDialog> {
  Future<int>? _future;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar ponto'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Deseja confirmar o registro de ponto?'),
            TextButton(
              child: Text('Selecionar Data'),
              onPressed: () {
                _selectDate(context);
              },
            ),
            Text('Data selecionada: ${getHoraFormatadaFromDateTime(_selectedDate)} '),
            TextButton(
              child: Text('Selecionar Hora'),
              onPressed: () {
                _selectTime(context);
              },
            ),
            Text('Hora selecionada: ${getHoraFormatadaFromTimeOfDay(_selectedTime)} '),
            RadioEntradaSaida(),

            if (_future != null)
              FutureBuilder<int>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return mostraCirularProgressIndicator();
                  } else {
                    if (snapshot.hasError || snapshot.data == -1) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        mostraDialogErroInclusaoPonto();
                      });
                    } else {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        mostraDialogIncluidoSucesso();
                      });
                    }
                  }
                  return Container();
                },
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              String dataMarcacaoPonto = getHoraFormatadaFromDateTime(_selectedDate);
              String horaMarcacaoPonto = getHoraFormatadaFromTimeOfDay(_selectedTime);
              _future = _incluirPonto(dataMarcacaoPonto, horaMarcacaoPonto);
            });
          },
          child: const Text('Registrar'),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
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

  Future<int> _incluirPonto(String dataMarcacaoPonto, String horaMarcacaoPonto) async {
    try {
      int? response = await ApiRequestService().postRegistraPonto(
        dataMarcacaoPonto,
        horaMarcacaoPonto,
        currentLocation,
        tipoMarcacao!,
        fusoHorarioMarcacao,
        true,
        "123.456.789-00",
        "Inicio de expediente",
        1,
        "I", // FONTE MARCACAO {I = marcação incluída manualmente}
        "576475e7-e365-4d71-be93-f8182866e102",
        true, // REGISTRO ALTERADO
        false // REGISTRO ALTERADO SEM APROVACAO
      );

      if (response == 200 || response == 202) {
        return 1;
      } else {
        return -1;
      }
    } catch (exc) {
      return -1;
    }
  }

  void mostraDialogErroInclusaoPonto() {
    showDialog(
      context: widget.parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Erro ao incluir ponto',
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

  void mostraDialogIncluidoSucesso() {
    showDialog(
      context: widget.parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enviado solicitacao de inclusao de registro de ponto!'),
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
}

///
/// TODO refatorar para um unico componente, compartilhado com [RegistrarPontoButton]
///
class RadioEntradaSaida extends StatefulWidget {
  const RadioEntradaSaida({Key? key}) : super(key: key);

  @override
  State<RadioEntradaSaida> createState() => _RadioEntradaSaidaState();
}

class _RadioEntradaSaidaState extends State<RadioEntradaSaida> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<TipoMarcacao>(
          title: const Text('Entrada'),
          value: TipoMarcacao.ENTRADA,
          groupValue: tipoMarcacao,
          onChanged: (TipoMarcacao? value) {
            setState(() {
              tipoMarcacao = value;
            });
          },
        ),
        RadioListTile<TipoMarcacao>(
          title: const Text('Saída'),
          value: TipoMarcacao.SAIDA,
          groupValue: tipoMarcacao,
          onChanged: (TipoMarcacao? value) {
            setState(() {
              tipoMarcacao = value;
            });
          },
        ),
      ],
    );
  }
}
