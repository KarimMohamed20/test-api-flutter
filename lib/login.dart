import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController name = TextEditingController();

  void getDataFromAPI() async {
    var response =
        await http.post('http://localhost:3000/login',
        body: {
          "name":name.text
        });
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                hintText: 'Name'
              ),
            ),
            RaisedButton(
              child: Text("Login",
              style: TextStyle(
                color: Colors.white
              ),),
              color: Colors.blue,
              onPressed: (){
              getDataFromAPI();
            })
          ],
        ),
      ),
    );
  }
}