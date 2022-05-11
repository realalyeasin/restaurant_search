import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

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

  final dio = Dio(BaseOptions(
      baseUrl:
          'https://api.spoonacular.com/recipes/716429/information?apiKey=179d4592a9354125ab7aa9ac3b8b3fb9&includeNutrition=true.',
      headers: {'apiKey': '179d4592a9354125ab7aa9ac3b8b3fb9'}));
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  List? _lists;
  Future searchRestaurents() async {
    final response = await widget.dio.get(
        'https://api.spoonacular.com/recipes/716429/information?apiKey=179d4592a9354125ab7aa9ac3b8b3fb9&includeNutrition=true.',
        queryParameters: {'diet': 'diet'});
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
    var image = [
      'images/bacon.png',
      'images/chicken.jpg',
      'images/picata.jpg',
    ];
    var card = Color.fromRGBO(125, 19, 115, 1);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Search Restaurant"),
        ),
        body: Stack(
          children: [
            CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.yellow,
                  expandedHeight: 240,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Swiper(
                        pagination:
                        SwiperPagination(alignment: Alignment.bottomCenter),
                        itemCount: 3,
                        itemBuilder: (BuildContext, index) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                image[index],
                                fit: BoxFit.fill,
                              ));
                        },
                        itemWidth: 400.0,
                        itemHeight: 240.0,
                        viewportFraction: 0.8,
                        scale: 0.9,
                        autoplay: false,
                        layout: SwiperLayout.STACK,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Swiper(
                      pagination: SwiperPagination(alignment: Alignment.bottomCenter),
                      itemCount: 3,
                      itemBuilder: (BuildContext, index) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(image[index], fit: BoxFit.fill,));
                      },
                      itemWidth: 400.0,
                      itemHeight: 240.0,
                      viewportFraction: 0.8,
                      scale: 0.9,
                      autoplay: false,
                      layout: SwiperLayout.STACK,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                filled: true,
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a proper name";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            color: Colors.yellow,
                            onPressed: () {
                              searchRestaurents();
                            },
                            focusColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Search",
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        _lists != null
                            ? Expanded(
                          child: ListView.separated(
                            itemCount: _lists!.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orangeAccent,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "ID - "
                                            '${_lists![index]['id'].toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Aisle - "
                                            '${_lists![index]['aisle'].toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Divider(
                                        height: 2,
                                        thickness: 2,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "Consistency - "
                                            '${_lists![index]['consistency'].toString()}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Name -"
                                            '${_lists![index]['name'].toString()}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Name Clean - "
                                            '${_lists![index]['nameClean'].toString()}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Original - "
                                            '${_lists![index]['original'].toString()}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Original Name  "
                                            '${_lists![index]['originalName'].toString()}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Amount - "
                                            '${_lists![index]['amount'].toString()}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Unit - "
                                            '${_lists![index]['unit'].toString()}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Measures(US) - "
                                            '${_lists![index]['measures']['us']['amount'].toString()}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                child: Divider(
                                  color: Colors.black,
                                  height: 1,
                                ),
                                height: 15,
                              );
                            },
                          ),
                        )
                            : Text('noo')
                      ])),
                )
              ],
            ),
          ],
        ),
        );
  }
}
