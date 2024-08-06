import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:process_run/shell.dart';

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {

    // mock para recuperar eventos do windows
    /*return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Eventos com ID 7001')),
        body: Center(child: EventsWithID7001Widget()),
      ),
    );
    */

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define a cor padrão para azul
      ),
      home: const LoginPage(),
    );
  }


}

class EventsWithID7001Widget extends StatefulWidget {
  @override
  _EventsWithID7001WidgetState createState() => _EventsWithID7001WidgetState();
}

class _EventsWithID7001WidgetState extends State<EventsWithID7001Widget> {
  String _events = 'Loading...';

  Future<String> getEventsWithID7001() async {
    var shell = Shell();
    try {
      var result = await shell.run('''
      powershell -Command "Get-WinEvent -LogName 'System' -MaxEvents 100 -FilterXPath "*[System[EventID=7001]] | Select-Object TimeCreated, Id
    ''');

      if (result.isNotEmpty && result[0].stdout != null) {
        return result[0].stdout.toString();
      } else {
        return 'No events with ID 7001 found';
      }
    } catch (e) {
      print('Error: $e');
      return 'Error retrieving events';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    var events = await getEventsWithID7001();
    setState(() {
      _events = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text('Eventos com ID 7001:\n$_events'),
    );
  }
}
