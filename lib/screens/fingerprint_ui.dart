import 'package:flutter/material.dart';

class Fingerprint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyImageAndContainer(),
      ),
    );
  }
}

class MyImageAndContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Column(
          children: [
            ClipRRect(
              child: Image.asset(
                'assets/flut.png',
                fit: BoxFit.cover,
                width: 2000,
              ),
            ),
            SizedBox(height: 20,),
            Icon(Icons.fingerprint_outlined, size: 150,
              color: Colors.purple[200],),
            SizedBox(height: 20,),
            Text(
              '28%',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25,),

            Text(
              'Touch the Sensor',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 20,height: 30,),
            Text(
              'Put you finger on the sensor and lift you feel\n'
                  'vibration.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        )
    );
  }
}