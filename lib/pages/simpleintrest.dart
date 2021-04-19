import 'dart:ui';

import 'package:flutter/material.dart';

class SimpleIntrest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SimpleIntrest> {
  final double _minpadding = 5.0;
  var _currencies = ['Rupees', 'Dollar', 'Pounds'];
  var _formkey = GlobalKey<FormState>();
  var _currentItem = '';
  TextEditingController principalcontroller = TextEditingController();
  TextEditingController roicontroller = TextEditingController();
  TextEditingController termcontroller = TextEditingController();

  String displaytext = "";
  @override
  void initState() {
    super.initState();
    _currentItem = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.subhead;

    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Simple Intrest App"),
        ),
        body: Form(
          key: _formkey,
          child: Padding(
              padding: EdgeInsets.all(_minpadding * 2),
              // margin: EdgeInsets.all(_minpadding * 2),
              child: ListView(
                children: <Widget>[
                  getImageAsset(),
                  Padding(
                    padding:
                        EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                    child: TextFormField(
                      style: style,
                      controller: principalcontroller,
                      validator: (String value) {
                         final isDigitsOnly = int.tryParse(value);
                        if (value.isEmpty) {
                          return 'Please enter principal ammount';
                        }else if(isDigitsOnly == null){
                                return 'Please enter only numbers';
                              }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          labelStyle: style,
                          errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                          hintText: 'Enter Principal e.g. 5000',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                    child: TextFormField(
                      style: style,
                      controller: roicontroller,
                      validator: (String value) {
                         final isDigitsOnly = int.tryParse(value);
                        if (value.isEmpty) {
                          return 'Please enter rate of intrest ammount';
                        }else if(isDigitsOnly == null){
                                return 'Please enter only numbers';
                              }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Rate of Intrest',
                          labelStyle: style,
                          errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                          hintText: 'In Percent',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _minpadding, bottom: _minpadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                            style: style,
                            keyboardType: TextInputType.number,
                            controller: termcontroller,
                            validator: (String value) {
                               final isDigitsOnly = int.tryParse(value);
                              if (value.isEmpty) {
                                return 'Please enter term ammount';
                              }
                              else if(isDigitsOnly == null){
                                return 'Please enter only numbers';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Term',
                                labelStyle: style,
                                errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                                hintText: 'Time in years',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),
                          Container(
                            width: _minpadding * 2,
                          ),
                          Expanded(
                              child: DropdownButton<String>(
                            items: _currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _currentItem,
                            onChanged: (String newValue) {
                              _onDropdownItemSelected(newValue);
                            },
                          ))
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _minpadding, bottom: _minpadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                                textColor: Theme.of(context).primaryColorDark,
                                color: Theme.of(context).accentColor,
                                child: Text(
                                  'Calculate',
                                  textScaleFactor: 1.5,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if(_formkey.currentState.validate()){
                                    this.displaytext = _calculateIntrest();
                                    }
                                  });
                                }),
                          ),
                          Expanded(
                            child: RaisedButton(
                                textColor: Theme.of(context).accentColor,
                                color: Theme.of(context).primaryColorDark,
                                child: Text(
                                  'Reset',
                                  textScaleFactor: 1.5,
                                ),
                                onPressed: () {
                                  _reset();
                                }),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _minpadding * 2, bottom: _minpadding * 2),
                      child: Text(
                        displaytext,
                        style: style,
                      ))
                ],
              )),
        ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minpadding * 10),
    );
  }

  void _onDropdownItemSelected(String newValue) {
    setState(() {
      this._currentItem = newValue;
    });
  }

  String _calculateIntrest() {
    double principal = double.parse(principalcontroller.text);
    double roi = double.parse(roicontroller.text);
    double term = double.parse(termcontroller.text);
    double ans = principal + (principal * roi * term) / 100;
    String result =
        'After $term years your investment will be worth $ans $_currentItem';
    return result;
  }

  void _reset() {
    principalcontroller.text = '';
    roicontroller.text = '';
    termcontroller.text = '';
    displaytext = '';
    _currentItem = _currencies[0];
  }
}
