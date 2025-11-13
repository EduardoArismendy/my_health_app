import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_health_app/src/feature/widgets/my_health_app_drawer.dart';

class AgeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyHealthAppDrawer(),
      appBar: AppBar(title: Text('Age Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the Age Screen'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
