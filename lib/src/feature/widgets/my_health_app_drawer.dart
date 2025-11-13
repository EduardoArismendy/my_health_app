import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyHealthAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'My Health App',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              context.go('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text('Age'),
            onTap: () {
              context.go('/age');
            },
          ),
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text('BMI'),
            onTap: () {
              context.go('/bmi');
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Zodiac'),
            onTap: () {
              context.go('/zodiac');
            },
          ),
        ],
      ),
    );
  }
}
