import 'package:flutter/material.dart';

class MeusPedidosLicencaPage extends StatelessWidget {
  const MeusPedidosLicencaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos de Licença'),
      ),
      body: ListView.builder(
        itemCount: 2, // Substitua isso pelo número real de itens
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Aprovado', // Substitua isso pelo status real do pedido
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Licença por doença', // Substitua isso pelo tipo real de licença
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Início',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '01/12/2022', // Substitua isso pela data real de início
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Fim',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '30/12/2022', // Substitua isso pela data real de fim
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
