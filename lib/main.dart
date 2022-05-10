import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.spoonacular.com/recipes/716429/information?apiKey=179d4592a9354125ab7aa9ac3b8b3fb9&includeNutrition=true.',
    headers: {
      'apiKey' : '179d4592a9354125ab7aa9ac3b8b3fb9'
    })
  );
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  List? _lists;
  Future searchRestaurents() async {
    final response = await widget.dio.get('https://api.spoonacular.com/recipes/716429/information?apiKey=179d4592a9354125ab7aa9ac3b8b3fb9&includeNutrition=true.',
    queryParameters: {
      'diet' : 'diet'
    });
    setState(() {
      _lists = response.data['extendedIngredients'];
      debugPrint(_lists.toString());
    });
  }
  @override
  void initState() {
    searchRestaurents();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Search Restaurant"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Form(
              key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
              onPressed: (){
                searchRestaurents();
              },
              focusColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              child: Text("Search", style: TextStyle(color: Colors.black, letterSpacing: 1, fontWeight: FontWeight.bold),),
            ),
          ),
            _lists !=null ? ListView.builder(
                itemCount: _lists!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext, index){
                  return Text(_lists![index]['id'].toString());
                }) : Text('noo')
        ]
        )));
  }
}
