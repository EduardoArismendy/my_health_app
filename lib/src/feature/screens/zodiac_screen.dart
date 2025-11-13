import 'package:flutter/material.dart';
import 'package:my_health_app/src/feature/widgets/my_health_app_drawer.dart';

class ZodiacScreen extends StatefulWidget {
  @override
  _ZodiacScreenState createState() => _ZodiacScreenState();
}

class _ZodiacScreenState extends State<ZodiacScreen> {
  DateTime? _birthDate;
  String? _sign;
  String? _message;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = _birthDate ?? DateTime(now.year - 20);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        _birthDate = picked;
        _sign = null;
        _message = null;
      });
    }
  }

  void _calculateSign() {
    if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor selecciona una fecha primero')),
      );
      return;
    }

    final now = DateTime.now();
    if (_birthDate!.isAfter(now)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('La fecha no puede ser en el futuro')),
      );
      return;
    }

    final pair = _getZodiacAndMessage(_birthDate!);
    setState(() {
      _sign = pair['sign'];
      _message = pair['message'];
    });
  }

  Map<String, String> _getZodiacAndMessage(DateTime date) {
    final m = date.month;
    final d = date.day;

    String sign = '';
    if ((m == 3 && d >= 21) || (m == 4 && d <= 19)) sign = 'Aries';
    else if ((m == 4 && d >= 20) || (m == 5 && d <= 20)) sign = 'Taurus';
    else if ((m == 5 && d >= 21) || (m == 6 && d <= 20)) sign = 'Gemini';
    else if ((m == 6 && d >= 21) || (m == 7 && d <= 22)) sign = 'Cancer';
    else if ((m == 7 && d >= 23) || (m == 8 && d <= 22)) sign = 'Leo';
    else if ((m == 8 && d >= 23) || (m == 9 && d <= 22)) sign = 'Virgo';
    else if ((m == 9 && d >= 23) || (m == 10 && d <= 22)) sign = 'Libra';
    else if ((m == 10 && d >= 23) || (m == 11 && d <= 21)) sign = 'Scorpio';
    else if ((m == 11 && d >= 22) || (m == 12 && d <= 21)) sign = 'Sagittarius';
    else if ((m == 12 && d >= 22) || (m == 1 && d <= 19)) sign = 'Capricorn';
    else if ((m == 1 && d >= 20) || (m == 2 && d <= 18)) sign = 'Aquarius';
    else if ((m == 2 && d >= 19) || (m == 3 && d <= 20)) sign = 'Pisces';

    final messages = {
      'Aries': 'Valiente y enérgico — hoy es un buen día para empezar algo nuevo.',
      'Taurus': 'Paciente y fiable — cuida lo que te da estabilidad.',
      'Gemini': 'Curioso y comunicativo — comparte tus ideas.',
      'Cancer': 'Emocional y protector — conecta con quienes amas.',
      'Leo': 'Creativo y generoso — deja que tu luz brille.',
      'Virgo': 'Práctico y analítico — organiza lo que importa.',
      'Libra': 'Equilibrado y justo — busca armonía hoy.',
      'Scorpio': 'Intenso y passionado — sigue tu intuición.',
      'Sagittarius': 'Aventurero y optimista — amplía tus horizontes.',
      'Capricorn': 'Ambicioso y disciplinado — enfócate en tus metas.',
      'Aquarius': 'Innovador y humanitario — comparte tu visión.',
      'Pisces': 'Soñador y compasivo — date permiso para crear.',
    };

    return {'sign': sign, 'message': messages[sign] ?? ''};
  }

  void _clear() {
    setState(() {
      _birthDate = null;
      _sign = null;
      _message = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyHealthAppDrawer(),
      appBar: AppBar(title: Text('Calculadora de Zodiaco')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('¿Cuál es tu signo zodiacal?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Selecciona tu fecha de nacimiento y pulsa calcular para conocer tu signo y un mensajito.'),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _pickDate,
                      child: Text(_birthDate == null
                          ? 'Seleccionar fecha'
                          : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'),
                    ),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(onPressed: _calculateSign, child: Text('Calcular')),
                ],
              ),

              SizedBox(height: 20),

              if (_sign != null)
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Signo: $_sign', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text(_message ?? ''),
                        SizedBox(height: 12),
                        Align(alignment: Alignment.centerRight, child: TextButton(onPressed: _clear, child: Text('Limpiar'))),
                      ],
                    ),
                  ),
                ),

              if (_sign == null)
                Expanded(
                  child: Center(
                    child: Text('Selecciona una fecha para ver tu signo y un mensaje amistoso.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[700])),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
