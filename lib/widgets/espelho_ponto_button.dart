import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/configuration/app_colors.dart';

class EspelhoPontoButton extends StatelessWidget {
  const EspelhoPontoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          // Ação a ser executada ao pressionar o botão
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EspelhoPonto()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
              horizontal: 30, vertical: 10), // Espaçamento interno do botão
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'espelho de ponto',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class EspelhoPonto extends StatelessWidget {
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  EspelhoPonto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.timelapse,
            color: AppColors.secondaryColor,
          ),
        ),
        Text(
          'Espelho de ponto',
          style: TextStyle(
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor),
        ),
      ])),
      body:
          //MySelector(),
          EspelhoPontoListView(items: items),
    );
  }
}

class MySelector extends StatefulWidget {
  const MySelector({super.key});

  @override
  _MySelectorState createState() => _MySelectorState();
}

class _MySelectorState extends State<MySelector> {
  String selectedValue = 'Janeiro';
  List<String> options = ['Janeiro', 'Fevereiro', 'Marco', 'Abril'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class EspelhoPontoListView extends StatefulWidget {
  final List<String> items;

  const EspelhoPontoListView({super.key, required this.items});

  @override
  State<EspelhoPontoListView> createState() => _EspelhoPontoListViewState();
}

class _EspelhoPontoListViewState extends State<EspelhoPontoListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MySelector(),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.items[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ],
    );
  }
}
