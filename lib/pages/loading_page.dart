import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 15),
            Text(
              'Carregando',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
