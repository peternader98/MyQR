import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to myQR',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
              ),
            ),
            const Padding(padding: EdgeInsets.all(40.0)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'create');
              },
              child: const Text('Create QR',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 5),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'scan');
              },
              child: const Text('Scan QR',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
