import 'package:converterrush/config/themes/color_schemes.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/login_door.png'),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hola!',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                'Bienvenido a tu transformador de HTML preferido',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                loginButtons(
                  'Iniciar Sesion',
                  () {
                    Navigator.pushNamed(context, 'loginScreen');
                  },
                ),
                loginButtons('Crear Cuenta', () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton loginButtons(String text, Function() action) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: defaultLightTheme.primary,
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(text),
    );
  }
}
