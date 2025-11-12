import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Home Screen!'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go('/age');
              },
              child: Text('Go to Age Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
