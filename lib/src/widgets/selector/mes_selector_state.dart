import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/utils/DateUtils.dart';

class MesSelector extends StatefulWidget {
  final void Function(String) onMesSelected;

  MesSelector({Key? key, required this.onMesSelected}) : super(key: key);

  @override
  State<MesSelector> createState() => _MesSelectorState();
}

class _MesSelectorState extends State<MesSelector> {
  String? selectedValue;

  List<String> options = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro ',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  @override
  void initState() {
    super.initState();
    selectedValue = getMonthName(DateTime.now().month);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: (value) =>
            {widget.onMesSelected(value!), updateState(value)},
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  updateState(String valor) {
    setState(() {
      selectedValue = valor;
    });
  }
}
