import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../../model/enums/tipo_marcacao.dart';
import '../../../services/api_request_service.dart';
import '../../../utils/date_utils.dart';
import '../radiobutton/radio_entrada_saida.dart';

LocationData currentLocation = LocationData.fromMap({
  'latitude': -23.5505,
  'longitude': -46.6333,
});

TipoMarcacao? tipoMarcacao = TipoMarcacao.ENTRADA;
const String fusoHorarioMarcacao = "GMT-3";

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
            Text('Data selecionada: ${formatDateTimeAAAAmmDD(_selectedDate)} '),
            TextButton(
              child: Text('Selecionar Hora'),
              onPressed: () {
                _selectTime(context);
              },
            ),
            Text('Hora selecionada: ${formatTimeOfDayHHmmSS(_selectedTime)} '),
            RadioEntradaSaida(
              tipoMarcacao: tipoMarcacao,
              onTipoMarcacaoChanged: (TipoMarcacao? value) {
                setState(() {
                  tipoMarcacao = value;
                });
              },
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
              String dataMarcacaoPonto = formatDateTimeAAAAmmDD(_selectedDate);
              String horaMarcacaoPonto = formatTimeOfDayHHmmSS(_selectedTime);
              _future = _incluirPonto(dataMarcacaoPonto, horaMarcacaoPonto);
            });
          },
          child: const Text('Registrar'),
        ),
      ],
    );
  }


}