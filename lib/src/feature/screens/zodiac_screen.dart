import 'package:flutter/material.dart';
import 'package:my_health_app/src/feature/widgets/my_health_app_drawer.dart';

class ZodiacScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyHealthAppDrawer(),
      appBar: AppBar(title: Text('Zodiac Signs')),
      body: Center(child: Text('Welcome to the Zodiac Screen!')),
    );
  }
}
