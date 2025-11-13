import 'package:flutter/material.dart';
import 'package:my_health_app/src/feature/widgets/my_health_app_drawer.dart';

class AgeScreen extends StatefulWidget {
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  DateTime? _birthDate;
  String? _result;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = _birthDate ?? DateTime(now.year - 25, now.month, now.day);
    final firstDate = DateTime(1900);
    final lastDate = now;

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        _birthDate = picked;
        _result = null;
      });
    }
  }

  void _calculateAge() {
    if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor selecciona una fecha de nacimiento')),
      );
      return;
    }

    final now = DateTime.now();
    if (_birthDate!.isAfter(now)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La fecha de nacimiento no puede ser en el futuro'),
        ),
      );
      return;
    }

    final age = _diffDates(_birthDate!, now);

    setState(() {
      _result = '${age.years} años, ${age.months} meses, ${age.days} días';
    });
  }

  _AgeParts _diffDates(DateTime from, DateTime to) {
    int yearDiff = to.year - from.year;
    int monthDiff = to.month - from.month;
    int dayDiff = to.day - from.day;

    if (dayDiff < 0) {
      final prevMonth = DateTime(to.year, to.month, 0);
      dayDiff += prevMonth.day;
      monthDiff -= 1;
    }

    if (monthDiff < 0) {
      monthDiff += 12;
      yearDiff -= 1;
    }

    return _AgeParts(years: yearDiff, months: monthDiff, days: dayDiff);
  }

  void _clear() {
    setState(() {
      _birthDate = null;
      _result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyHealthAppDrawer(),
      appBar: AppBar(title: Text('Calculadora de edad')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Selecciona tu fecha de nacimiento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _pickDate,
                      child: Text(
                        _birthDate == null
                            ? 'Seleccionar fecha'
                            : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _calculateAge,
                    child: Text('Calcular'),
                  ),
                ],
              ),

              SizedBox(height: 20),

              if (_result != null)
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resultado',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(_result!, style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text(
                          'Fecha seleccionada: ${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _clear,
                            child: Text('Limpiar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              if (_result == null)
                Expanded(
                  child: Center(
                    child: Text(
                      'Introduce tu fecha de nacimiento y pulsa "Calcular" para ver tu edad.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgeParts {
  final int years;
  final int months;
  final int days;
  _AgeParts({required this.years, required this.months, required this.days});
}
