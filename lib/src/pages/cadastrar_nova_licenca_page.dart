import 'package:flutter/material.dart';

class CadastrarNovaLicencaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Nova Licença'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Data Início'),
                keyboardType: TextInputType.datetime,
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Duração licença em dias'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data fim'),
                keyboardType: TextInputType.datetime,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Código C.I.D'),
              ),
              DropdownButtonFormField<String>(
                decoration:
                    InputDecoration(labelText: 'País do profissional de saúde'),
                items: <String>['Brasil', 'Argentina', 'Chile']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              DropdownButtonFormField<String>(
                decoration:
                    InputDecoration(labelText: 'Estado profissional de saúde'),
                items: <String>['São Paulo', 'Rio de Janeiro', 'Minas Gerais']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              // Aqui você pode adicionar o seletor para CRM ou CRO
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Número conselho regional'),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Nome completo profissional de saúde'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Processar os dados
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
