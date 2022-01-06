import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollar', 'Others'];
  var dropdownValue = '';
  @override
  void initState() {
    super.initState();
    dropdownValue = _currencies[0];
  }

  var result = '';
  TextEditingController principalcontroller = TextEditingController();
  TextEditingController roicontroller = TextEditingController();
  TextEditingController termcontroller = TextEditingController();
  bool _switchvalue = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _switchvalue ? _lighttheme : _darktheme,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Simple Interest Calculator"),
            actions: [
              Switch(
                value: _switchvalue,
                onChanged: (newValue) {
                  setState(() {
                    _switchvalue = newValue;
                  });
                },
              )
            ],
          ),
          body: Form(
            key: _formkey,
            child: Padding(
                padding: EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    imageAsset(),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextFormField(
                        style: TextStyle(
                            fontFamily: 'Roboto', fontWeight: FontWeight.w700),
                        keyboardType: TextInputType.number,
                        controller: principalcontroller,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter principl ammount';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Principal',
                            labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700),
                                errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15.0
                                ),
                            hintText: '12000',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(
                          fontFamily: 'Roboto', fontWeight: FontWeight.w700),
                      keyboardType: TextInputType.number,
                      controller: roicontroller,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter rate of interest';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate of Interest',
                          hintText: '10%',
                          errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15.0
                                ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700),
                            keyboardType: TextInputType.number,
                            controller: termcontroller,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter term';
                              }
                              
                            },
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15.0
                                ),
                                labelText: 'Term',
                                hintText: 'Year',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),
                          Container(width: 25.0),
                          Expanded(
                              child: DropdownButton<String>(
                            items: _currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700),
                                ),
                              );
                            }).toList(),
                            value: dropdownValue,
                            onChanged: (String? newvalue) {
                              setState(() {
                                dropdownValue = newvalue!;
                              });
                            },
                          )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: RaisedButton(
                          color: Colors.green,
                          child: Text("Calculate"),
                          onPressed: () {
                            setState(() {
                              if (_formkey.currentState!.validate()) {
                                this.result = _calculateReturn();
                              }
                            });
                          },
                        )),
                        Container(width: 5.0),
                        Expanded(
                            child: RaisedButton(
                          color: Colors.red,
                          child: Text("Reset"),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        )),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.all(45.0),
                        child: Center(
                          child: Text(
                            this.result,
                            style: TextStyle(
                                color: Colors.pink,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                fontSize: 20.0),
                          ),
                        ))
                  ],
                )),
          )),
    );
  }

  String _calculateReturn() {
    double principal = double.parse(principalcontroller.text);
    double roi = double.parse(roicontroller.text);
    double term = double.parse(termcontroller.text);
    double interest = (principal * roi * term) / 100;
    double totalAmmountPay = principal + interest;
    String result =
        'Interest Earned: $interest $dropdownValue & Total Value: $totalAmmountPay $dropdownValue';
    return result;
  }

  void _reset() {
    principalcontroller.text = '';
    roicontroller.text = '';
    termcontroller.text = '';
    result = '';
    dropdownValue = _currencies[0];
  }
}

Widget imageAsset() {
  AssetImage assetImage = AssetImage('images/interest.png');
  Image image = Image(image: assetImage);
  return Container(child: image, width: 300.0, height: 250.0);
}

final _darktheme = ThemeData(
  brightness: Brightness.dark,
);

final _lighttheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.greenAccent);
