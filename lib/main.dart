import 'package:flutter/material.dart';
import 'pages/simpleintrest.dart';
void main() {
  runApp(MaterialApp(
    title: "Statefull Widget",
    debugShowCheckedModeBanner: false,
    home: SimpleIntrest(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent
      
    ),
  ));
}

class FavCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavCityState();
  }
}

class _FavCityState extends State<FavCity> {
  String cityName = "";
  var _currencies = ['Rupees', 'Dollar', 'Pounds', 'Others'];
  String _currentItem = 'Rupees'; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statefull App Example"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextField(
              onSubmitted: (String name) {
                setState(() {
                  cityName = name;
                });
              },
            ),
            DropdownButton<String>(
                items: _currencies.map((String dropdownStringItem) {
                  return DropdownMenuItem<String>(
                    child: Text(dropdownStringItem),
                    value: dropdownStringItem,
                  );
                }).toList(),
                onChanged:(String newSelectedItem){
                  setState(() {
                    this._currentItem = newSelectedItem;
                  });
                },
                value: _currentItem
                 ),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "City : $cityName",
                  style: TextStyle(fontSize: 20.0),
                )),
          ],
        ),
      ),
    );
  }
}
