import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/services/api_request_service.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../../model/enums/tipo_registro.dart';

LocationData currentLocation = LocationData.fromMap({
  'latitude': -23.5505,
  'longitude': -46.6333,
});

TipoRegistro? tipoRegistro = TipoRegistro.E;

class RegistrarPontoButton extends StatelessWidget {
  const RegistrarPontoButton({Key? key}) : super(key: key);

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
              return RegistrarPontoApiCallDialog();
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

class RegistrarPontoApiCallDialog extends StatelessWidget {
  const RegistrarPontoApiCallDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar ponto'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Deseja confirmar o registro de ponto?'),
            RadioEntradaSaida(),
            MapScreen(),
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
            Navigator.of(context).pop();
            _registraPonto(context);
          },
          child: const Text('Registrar'),
        ),
      ],
    );
  }

  void _registraPonto(BuildContext context) async {
    try {
      int response = await ApiRequestService().postRegistraPonto(
        currentLocation,
        tipoRegistro!,
        "GMT-3",
        true,
        "123.456.789-00",
        "Inicio de expediente",
        1,
        "O",
        "576475e7-e365-4d71-be93-f8182866e102",
      );

      if (response == 200 || response == 202) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ponto registrado com sucesso'),
            backgroundColor: AppLayoutDefaults.sucessColor,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro durante registro de ponto'),
            backgroundColor: AppLayoutDefaults.errorColor,
          ),
        );
      }
    } catch (exc) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro durante registro de ponto'),
          backgroundColor: AppLayoutDefaults.errorColor,
        ),
      );
    }
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
        RadioListTile<TipoRegistro>(
          title: const Text('Entrada'),
          value: TipoRegistro.E,
          groupValue: tipoRegistro,
          onChanged: (TipoRegistro? value) {
            setState(() {
              tipoRegistro = value;
            });
          },
        ),
        RadioListTile<TipoRegistro>(
          title: const Text('Saída'),
          value: TipoRegistro.S,
          groupValue: tipoRegistro,
          onChanged: (TipoRegistro? value) {
            setState(() {
              tipoRegistro = value;
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
