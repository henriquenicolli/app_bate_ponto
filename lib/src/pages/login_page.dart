import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/services/api_request_service.dart';
import 'package:flutter_app_bate_ponto/src/widgets/navigation/navigation_bar.dart';
import '../configuration/app_layout_defaults.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  ApiRequestService apiRequestService = ApiRequestService();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.timelapse,
                        color: AppLayoutDefaults.secondaryColor,
                      ),
                    ),
                    Text(
                      'Bate Ponto',
                      style: TextStyle(
                          fontFamily: AppLayoutDefaults.fontFamily,
                          fontWeight: FontWeight.bold,
                          color: AppLayoutDefaults.secondaryColor),
                    ),
                  ],
                ),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: loginController,
                  decoration: const InputDecoration(
                    labelText: 'Cnpj / cpf / email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  height: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppLayoutDefaults.secondaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      int? loginStatus = await apiRequestService.login(loginController.text, senhaController.text);

                      if (loginStatus == 200) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CustomNavigationBar()),
                        );
                      } else {
                        mostrarDialogFalhaLogin(context);
                      }
                    },
                    child: Text('Entrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


void mostrarDialogFalhaLogin(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Erro de Login',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Usuário ou senha incorretos. Por favor, tente novamente.',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}