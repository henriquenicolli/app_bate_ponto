import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/pages/atestados_licencas_page.dart';
import 'package:flutter_app_bate_ponto/src/pages/ferias_page.dart';
import 'package:flutter_app_bate_ponto/src/pages/remuneracao_page.dart';

const String REMUNERACAO_PAGE = 'remuneração';
const String FERIAS_PAGE = 'férias';
const String ATESTADOS_LICENCAS_PAGE = 'atestados e licenças';

class ParaMimPage extends StatelessWidget {
  const ParaMimPage({Key? key}) : super(key: key);

  String getMenuText(int index) {
    switch (index) {
      case 0:
        return REMUNERACAO_PAGE;
      case 1:
        return FERIAS_PAGE;
      //case 2:
      //  return 'benefícios';
      case 2:
        return ATESTADOS_LICENCAS_PAGE;
      //case 4:
      //  return 'acompanhe';
      default:
        return '';
    }
  }

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
      itemCount: 3, // Número total de itens
    );
  }
}

class MenuButton extends StatelessWidget {
  final String buttonText;

  const MenuButton({Key? key, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            switch (buttonText) {
              case REMUNERACAO_PAGE:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RemuneracaoPage()),
                );
                break;
              case FERIAS_PAGE:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeriasPage()),
                );
                break;
              case ATESTADOS_LICENCAS_PAGE:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AtestadosLicencasPage()),
                );
                break;
              default:
                break;
            }
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
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
