import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MaterialColor theme = Colors.blue;

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Informe os seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _info = "Informe os seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculateIMC() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;

    double imc = weight / (height * height);
    String formatImc = imc.toStringAsPrecision(4);

    setState(() {
      if (imc < 17)
        _info = "IMC: $formatImc (Muito abaixo do peso)";
      else if (imc >= 17 && imc <= 18.49)
        _info = "IMC: $formatImc (Abaixo do peso)";
      else if (imc >= 18.5 && imc <= 24.99)
        _info = "IMC: $formatImc (Peso normal)";
      else if (imc >= 25 && imc <= 29.99)
        _info = "IMC: $formatImc (Acima do peso)";
      else if (imc >= 30 && imc <= 34.99)
        _info = "IMC: $formatImc (Obesidade I)";
      else if (imc >= 35 && imc <= 39.99)
        _info = "IMC: $formatImc (Obesidade II (severa))";
      else
        _info = "IMC: $formatImc (Obesidade III (mórbida))";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: theme,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: theme),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso: (kg)",
                        labelStyle: TextStyle(color: theme)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: theme, fontSize: 25.0),
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso!";
                      }
                    }),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: theme)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: theme, fontSize: 25.0),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua altura!";
                      }
                    }),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if(_formKey.currentState.validate()) {
                            _calculateIMC();
                          }
                        },
                        child: Text("Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0)),
                        color: theme,
                      )),
                ),
                Text("$_info",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: theme, fontSize: 25.0))
              ],
            ),
          )),
    );
  }
}
