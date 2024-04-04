import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/pages/cadastrar_nova_licenca_page.dart';
import 'package:flutter_app_bate_ponto/src/pages/meus_pedidos_licenca_page.dart';

const String CADASTRAR_LICENCA_PAGE = 'Cadastrar Licenca';
const String MEUS_PEDIDOS_LICENCA_PAGE = 'Meus Pedidos Licenca';

class AtestadosLicencasPage extends StatelessWidget {
  const AtestadosLicencasPage({super.key});

  String getMenuText(int index) {
    switch (index) {
      case 0:
        return CADASTRAR_LICENCA_PAGE;
      case 1:
        return MEUS_PEDIDOS_LICENCA_PAGE;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 200).floor();

    return Scaffold(
      appBar: AppBar(
        title: Text('Remuneração'),
      ),
      body: GridView.builder(
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
        itemCount: 2, // Número total de itens
      ),
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
              case CADASTRAR_LICENCA_PAGE:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CadastrarNovaLicencaPage()),
                );
                break;
              case MEUS_PEDIDOS_LICENCA_PAGE:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MeusPedidosLicencaPage()),
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
