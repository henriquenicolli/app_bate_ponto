import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';

class ParaMimPage extends StatelessWidget {
  const ParaMimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: const MenuButton(buttonText: 'remuneração'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const MenuButton(buttonText: 'férias'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const MenuButton(buttonText: 'benefícios'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const MenuButton(buttonText: 'atestados e licenças'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const MenuButton(buttonText: 'acompanhe'),
        ),
        //Container(
        //  padding: const EdgeInsets.all(8),
        //  child: const MenuButton(),
        //),
      ],
    );
  }
}

class MenuButton extends StatelessWidget {
  final String buttonText;

  const MenuButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Ação a ser executada ao pressionar o botão
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppLayoutDefaults.secondaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
