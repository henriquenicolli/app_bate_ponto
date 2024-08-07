import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/services/api_request_service.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../../../model/enums/tipo_marcacao.dart';

LocationData currentLocation = LocationData.fromMap({
  'latitude': -23.5505,
  'longitude': -46.6333,
});

TipoMarcacao? tipoMarcacao = TipoMarcacao.ENTRADA;
const String fusoHorarioMarcacao = "GMT-3";

///
/// Classe [RegistrarPontoButton], componente do botão RegistrarPonto que ao ser clicado exibe um dialogo
///
class RegistrarPontoButton extends StatefulWidget {
  const RegistrarPontoButton({Key? key}) : super(key: key);

  @override
  State<RegistrarPontoButton> createState() => _RegistrarPontoButtonState();
}

class _RegistrarPontoButtonState extends State<RegistrarPontoButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return RegistrarPontoCallDialog(parentContext: context);
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppLayoutDefaults.secondaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Registrar ponto',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

///
/// Classe [RegistrarPontoCallDialog], componente que exibe um dialog com a opcao de realizar um registro de ponto
///
class RegistrarPontoCallDialog extends StatefulWidget {
  final BuildContext parentContext;

  const RegistrarPontoCallDialog({Key? key, required this.parentContext}) : super(key: key);

  @override
  State<RegistrarPontoCallDialog> createState() => _RegistrarPontoCallDialogState();
}

class _RegistrarPontoCallDialogState extends State<RegistrarPontoCallDialog> {
  Future<int>? _future;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar ponto'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Deseja confirmar o registro de ponto?'),
            RadioEntradaSaida(),
            MapScreen(),
            if (_future != null)
              FutureBuilder<int>(
                future: _future,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return mostraCirularProgressIndicator();
                  } else {
                    if (snapshot.hasError || snapshot.data == -1) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        mostraDialogErroRegistroPonto();
                      });
                    } else {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        mostraDialogRegistradoSucesso();
                      });
                    }
                  }
                  return Container();
                },
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _future = _registraPonto();
            });
          },
          child: const Text('Registrar'),
        ),
      ],
    );
  }

  Center mostraCirularProgressIndicator() {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<int> _registraPonto() async {
    try {

      int? response = await ApiRequestService().postRegistraPonto(
        currentLocation,
        tipoMarcacao!,
        fusoHorarioMarcacao,
        true,
        "123.456.789-00",
        "Inicio de expediente",
        1,
        "O",
        "576475e7-e365-4d71-be93-f8182866e102",
      );

      if (response == 200 || response == 202) {
        return 1;
      } else {
        return -1;
      }
    } catch (exc) {
      return -1;
    }
  }

  void mostraDialogErroRegistroPonto() {
    showDialog(
      context: widget.parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Erro ao registrar ponto',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Servico indisponivel. Por favor, tente novamente.',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void mostraDialogRegistradoSucesso() {
    showDialog(
      context: widget.parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ponto registrado com sucesso!'),
          actions: [
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class RadioEntradaSaida extends StatefulWidget {
  const RadioEntradaSaida({Key? key}) : super(key: key);

  @override
  State<RadioEntradaSaida> createState() => _RadioEntradaSaidaState();
}

class _RadioEntradaSaidaState extends State<RadioEntradaSaida> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<TipoMarcacao>(
          title: const Text('Entrada'),
          value: TipoMarcacao.ENTRADA,
          groupValue: tipoMarcacao,
          onChanged: (TipoMarcacao? value) {
            setState(() {
              tipoMarcacao = value;
            });
          },
        ),
        RadioListTile<TipoMarcacao>(
          title: const Text('Saída'),
          value: TipoMarcacao.SAIDA,
          groupValue: tipoMarcacao,
          onChanged: (TipoMarcacao? value) {
            setState(() {
              tipoMarcacao = value;
            });
          },
        ),
      ],
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          throw 'Serviço de localização desativado.';
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          throw 'Permissão de localização não concedida.';
        }
      }

      _locationData = await location.getLocation();
      setState(() {
        currentLocation = _locationData;
        mapController.move(
          LatLng(currentLocation.latitude!, currentLocation.longitude!),
          17,
        );
      });
    } catch (e) {
      print('Erro ao obter localização: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          initialZoom: 14,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => print(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
          MarkerLayer(markers: [
            Marker(
              point: LatLng(currentLocation.latitude!, currentLocation.longitude!),
              width: 80,
              height: 80,
              child: const Icon(
                Icons.location_on,
                size: 40,
                color: Colors.red,
              ),
            ),
          ])
        ],
      ),
    );
  }
}
