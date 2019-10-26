import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _heightController = new TextEditingController();
  final TextEditingController _weightController = new TextEditingController();
  double _bmi = 0.0;
  String _resultReading = "";

  void _calculateBmi() {
    setState(() {
      int age = int.parse(_ageController.text);
      double height = double.parse(_heightController.text);
      double weight = double.parse(_weightController.text);
      if (_ageController.text.toString().isNotEmpty ||
          age > 0 && _weightController.text.toString().isNotEmpty ||
          weight > 0 && _heightController.text.toString().isNotEmpty ||
          height > 0) {
        _bmi = ((weight / (height * height))) * 10000;
        _bmi = double.parse(_bmi.toStringAsFixed(2));
        if (double.parse(_bmi.toStringAsFixed(1)) < 18.5) {
          _resultReading = "Underweight";
        } else if (double.parse(_bmi.toStringAsFixed(1)) > 18.5 &&
            double.parse(_bmi.toStringAsFixed(1)) < 24.9) {
          _resultReading = "Normal";
        } else if (double.parse(_bmi.toStringAsFixed(1)) > 25 &&
            double.parse(_bmi.toStringAsFixed(1)) < 29.9) {
          _resultReading = "Overweight";
        } else {
          _resultReading = "Obese";
        }
      } else {
        _bmi = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Checker"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: const EdgeInsets.all(3.0),
          children: <Widget>[
            Image.asset(
              "images/bmilogo.png",
              height: 100,
              width: 100,
            ),
            Padding(padding: const EdgeInsets.all(10)),
            Container(
              margin: const EdgeInsets.all(3.0),
              height: 260,
              width: 290,
              color: Colors.grey.shade300,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Age",
                      hintText: "e.g. 34",
                      icon: Icon(Icons.person_outline),
                    ),
                  ),
                  TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Height",
                      hintText: "e.g. 172 cm",
                      icon: Icon(Icons.insert_chart),
                    ),
                  ),
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Weight",
                      hintText: "e.g. 80 kg",
                      icon: Icon(Icons.line_weight),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(10)),
                  Container(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      onPressed: _calculateBmi,
                      color: Colors.blueAccent,
                      child: Text("Calculate"),
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(11)),
                Text(
                  "BMI: $_bmi",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue),
                ),
                Padding(padding: const EdgeInsets.all(7)),
                Text(
                  "$_resultReading",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: _resultReading == "Overweight"
                          ? Colors.redAccent
                          : _resultReading == "Obese"
                              ? Colors.red
                              : _resultReading == "Normal"
                                  ? Colors.green
                                  : Colors.blue),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
