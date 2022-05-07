import 'package:flutter/material.dart';

void main() {
  runApp(const Restaurant());
}

class Restaurant extends StatelessWidget {
  const Restaurant({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Restaurant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Search Restaurant"),
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              Form(
                  key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        border: OutlineInputBorder()),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Please enter a proper name";
                          }
                          return null;
                        },
                  ),),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  color: Colors.yellow,
                  onPressed: (){},
                  child: Text("Search", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
              )
          ],
        ),
            )));
  }
}
