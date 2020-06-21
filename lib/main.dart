import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_api_app/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var key = GlobalKey<ScaffoldState>();

  List data = [];

  void getDataFromAPI() async {
    var response =
        await http.get('https://jsonplaceholder.typicode.com/photos');
    
    var responseList = jsonDecode(response.body);
    setState(() {
      data = responseList;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataFromAPI();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: Image.network('https://www.publicdomainpictures.net/pictures/270000/velka/avatar-people-person-business-.jpg'),
                  accountName: Text('Karim'),
                  accountEmail: Text("karim@dplyr.dev")),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Scaffold(
                      appBar: AppBar(title: Text("Home"),),
                      body: Text("Home"),);
                  }));
                },
                trailing: Icon(Icons.home),
                title: Text("Home"),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
                },
                trailing: Icon(Icons.navigate_next),
                title: Text("Login"),
              ),
              ListTile(
                trailing: Icon(Icons.delete),
                title: Text("Delete Account"),
              )
            ],
          ),
        ),
        key: key,
        appBar: AppBar(
          title: Text('Test API'),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              print(i);
              return Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      key.currentState.showSnackBar(SnackBar(
                        content: Text("Id: " + data[i]['id'].toString()),
                      ));
                    },
                    leading: Image.network(data[i]['url']),
                    trailing: Image.network(data[i]['thumbnailUrl']),
                    title: Text(data[i]['title']),
                  ),
                  Divider()
                ],
              );
            }));
  }
}
