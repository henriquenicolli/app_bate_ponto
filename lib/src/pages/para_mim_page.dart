import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';

class ParaMimPage extends StatelessWidget {
  const ParaMimPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 200).floor();

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: MenuButton(buttonText: getMenuText(index)),
        );
      },
      itemCount: 5, // Número total de itens
    );
  }

  String getMenuText(int index) {
    switch (index) {
      case 0:
        return 'remuneração';
      case 1:
        return 'férias';
      case 2:
        return 'benefícios';
      case 3:
        return 'atestados e licenças';
      case 4:
        return 'acompanhe';
      default:
        return '';
    }
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
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
