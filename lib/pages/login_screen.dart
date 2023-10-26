import 'package:converterrush/config/themes/color_schemes.dart';
import 'package:converterrush/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100.0,
              height: 100.0,
              child: Image.asset('assets/images/login_door.png'),
            ),
            Column(
              children: [
                CustomTextField(
                  controller: usernameController,
                  hintText: 'Usuario',
                  obscureText: true,
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (usernameController.text == "edison" &&
                    passwordController.text == "edison") {
                  Navigator.pushNamed(context, 'dashboardScreen');
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error al Iniciar Sesion'),
                        content: const Text('Usuario o contraseña incorrectos'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Aceptar"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: defaultLightTheme.primary,
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Acceder'),
            ),
          ],
        ),
      ),
    );
  }
}
