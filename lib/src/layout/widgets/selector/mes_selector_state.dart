import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/utils/date_utils.dart';

class MesSelector extends StatefulWidget {
  final void Function(String) onMesSelected;

  const MesSelector({Key? key, required this.onMesSelected}) : super(key: key);

  @override
  State<MesSelector> createState() => _MesSelectorState();
}

class _MesSelectorState extends State<MesSelector> {
  late String selectedValue;

  List<String> options = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedValue,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedValue = value;
              });
              widget.onMesSelected(value);
            }
          },
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
