import 'package:flutter/material.dart';
import 'package:my_health_app/src/feature/widgets/my_health_app_drawer.dart';

class BmiScreen extends StatefulWidget {
  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String? _resultText;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateBmi() {
    final weight = double.tryParse(_weightController.text.replaceAll(',', '.'));
    final heightCm = double.tryParse(_heightController.text.replaceAll(',', '.'));

    if (weight == null || heightCm == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Introduce valores numéricos válidos para peso y altura.')),
      );
      return;
    }

    if (weight <= 0 || heightCm <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El peso y la altura deben ser mayores que cero.')),
      );
      return;
    }

    final heightM = heightCm / 100.0;
    final bmi = weight / (heightM * heightM);
    final bmiRounded = double.parse(bmi.toStringAsFixed(1));
    final category = _bmiCategory(bmi);

    setState(() {
      _resultText = 'IMC: $bmiRounded\nCategoría: $category';
    });
  }

  String _bmiCategory(double bmi) {
    if (bmi < 18.5) return 'Bajo peso';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Sobrepeso';
    return 'Obesidad';
  }

  void _clear() {
    _weightController.clear();
    _heightController.clear();
    setState(() => _resultText = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyHealthAppDrawer(),
      appBar: AppBar(title: Text('Calculadora BMI')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Índice de Masa Corporal (BMI)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Introduce tu peso en kg y tu altura en cm. Por ejemplo: 70 kg, 175 cm.'),
              SizedBox(height: 16),

              TextField(
                controller: _weightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monitor_weight),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.height),
                ),
              ),

              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calculateBmi,
                      child: Text('Calcular'),
                    ),
                  ),
                  SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: _clear,
                    child: Text('Limpiar'),
                  ),
                ],
              ),

              SizedBox(height: 20),

              if (_resultText != null)
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_resultText!, style: TextStyle(fontSize: 16)),
                  ),
                ),

              if (_resultText == null)
                Expanded(
                  child: Center(
                    child: Text('Introduce tus datos y pulsa "Calcular" para ver el resultado.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[700])),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
