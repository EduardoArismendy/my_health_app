import 'package:flutter/material.dart';
import 'package:my_health_app/src/feature/widgets/my_health_app_drawer.dart';

class BmiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyHealthAppDrawer(),
      appBar: AppBar(title: Text('BMI Calculator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the BMI Calculator',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to BMI calculation screen
              },
              child: Text('Calculate BMI'),
            ),
          ],
        ),
      ),
    );
  }
}
