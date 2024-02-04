import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/configuration/app_colors.dart';

class CustomToggleButtons extends StatelessWidget {
  const CustomToggleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ToggleButtons(title: 'Ponto eletrônico');
  }
}

class _ToggleButtons extends StatefulWidget {
  const _ToggleButtons({super.key, required this.title});

  final String title;

  @override
  State<_ToggleButtons> createState() => _ToggleButtonsState();
}

class _ToggleButtonsState extends State<_ToggleButtons> {
  final List<bool> _selectedState = <bool>[false, true];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < _selectedState.length; i++) {
                    _selectedState[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: AppColors.secondaryColor,
              selectedColor: AppColors.backgroundColor,
              fillColor: AppColors.secondaryColor,
              color: AppColors.secondaryColor,
              isSelected: _selectedState,
              children: texts,
            )
          ],
        ),
      ),
    );
  }
}

const List<Widget> texts = <Widget>[
  Padding(
    padding: EdgeInsets.all(10.0),
    child: Text('ponto de ontem'),
  ),
  Padding(
    padding: EdgeInsets.all(10.0),
    child: Text('ponte de hoje'),
  ),
];
