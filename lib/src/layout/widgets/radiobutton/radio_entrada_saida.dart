

import 'package:flutter/material.dart';

import '../../../model/enums/tipo_marcacao.dart';

class RadioEntradaSaida extends StatefulWidget {
  final ValueChanged<TipoMarcacao?> onTipoMarcacaoChanged;
  final TipoMarcacao? tipoMarcacao;


  const RadioEntradaSaida({
    Key? key,
    required this.onTipoMarcacaoChanged,
    this.tipoMarcacao,
  }) : super(key: key);

  @override
  State<RadioEntradaSaida> createState() => _RadioEntradaSaidaState();
}

class _RadioEntradaSaidaState extends State<RadioEntradaSaida> {

  TipoMarcacao? tipoMarcacao;

  @override
  void initState() {
    super.initState();
    tipoMarcacao = widget.tipoMarcacao;
  }


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
            widget.onTipoMarcacaoChanged(value);
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
            widget.onTipoMarcacaoChanged(value);
          },
        ),
      ],
    );
  }
}