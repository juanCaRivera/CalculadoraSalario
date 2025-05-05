import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Salario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalculadoraSalario(),
    );
  }
}

class CalculadoraSalario extends StatefulWidget {
  const CalculadoraSalario({super.key});

  @override
  State<CalculadoraSalario> createState() => _CalculadoraSalarioState();
}

class _CalculadoraSalarioState extends State<CalculadoraSalario> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _salarioController = TextEditingController();

  double inssLaboral = 0;
  double irLaoral = 0;
  double totalDeducciones = 0;

  void _calcularDeducciones() {
    if (_formKey.currentState!.validate()) {
      double salario = double.parse(_salarioController.text);
      inssLaboral = 0.07 * salario;

      double salarioDespuesINSS = salario - inssLaboral;
      irLaoral = salarioDespuesINSS * 0.15;
      totalDeducciones = inssLaboral + irLaoral;

      setState(() {});
    }
  }

  void _limpiarDatos() {
    _nombreController.clear();
    _salarioController.clear();
    setState(() {
      inssLaboral = 0;
      irLaoral = 0;
      totalDeducciones = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Calculadora de Salario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre Completo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _salarioController,
                decoration: const InputDecoration(
                  labelText: 'Salario Mensual',
                  border: OutlineInputBorder(),
                ),

                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su salario';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingrese un valor numérico válido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calcularDeducciones,
                      child: const Text('Calcular'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _limpiarDatos,
                      child: const Text('Limpiar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('INSS Laboral: \$${inssLaboral.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      Text('IR Laboral: \$${irLaoral.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      Text(
                        'Total Deducciones: \$${totalDeducciones.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _salarioController.dispose();
    super.dispose();
  }
}
