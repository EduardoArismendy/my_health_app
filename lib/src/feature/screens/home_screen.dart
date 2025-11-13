import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_health_app/src/feature/widgets/my_health_app_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyHealthAppDrawer(),
      appBar: AppBar(title: Text('My Health App'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                'Calculadora de salud',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Calcula tu edad estimada, tu signo zodiacal y tu índice de masa corporal (BMI).',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),

              // Features grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3 / 2,
                  children: [
                    _FeatureCard(
                      icon: Icons.cake,
                      title: 'Age',
                      subtitle: 'Calcula años',
                      color: Colors.orange.shade600,
                      onTap: () => context.go('/age'),
                    ),
                    _FeatureCard(
                      icon: Icons.star,
                      title: 'Zodiac',
                      subtitle: 'Tu signo',
                      color: Colors.purple.shade600,
                      onTap: () => context.go('/zodiac'),
                    ),
                    _FeatureCard(
                      icon: Icons.fitness_center,
                      title: 'BMI',
                      subtitle: 'Índice de masa corporal',
                      color: Colors.green.shade600,
                      onTap: () => context.go('/bmi'),
                    ),
                    _FeatureCard(
                      icon: Icons.info_outline,
                      title: 'Acerca',
                      subtitle: 'Información de la app',
                      color: Colors.blueGrey.shade600,
                      onTap: () => showAboutDialog(
                        context: context,
                        applicationName: 'My Health App',
                        applicationVersion: '1.0.0',
                        children: [
                          Text('Calculadora simple para edad, signo y BMI.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
