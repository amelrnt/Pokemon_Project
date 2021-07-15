import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon/detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pokemon/model/pokemon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<AllPokemon> pokemonData;
  bool _isLoading = false;
  TextEditingController _controllerSearch = new TextEditingController();

  @override
  void initState() {
    pokemonData = getAllPokemon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<AllPokemon>(
        future: getAllPokemon(),
        builder:(context,snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Form(
                      child: Row(
                        children: <Widget>[
                          TextField(
                            onChanged: (enteredKeyword) {
                              List<Result> results = [];
                              if (enteredKeyword.isEmpty) {
                                /// if the search field is empty or only contains white-space, we'll display all users
                                results = snapshot.data!.results;
                              } else {
                                results = snapshot.data!.results
                                    .where((data) =>
                                        data.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
                                    .toList();
                              }
                              // Refresh the UI
                              setState(() {
                                snapshot.data!.results.removeRange(0, snapshot.data!.results.length-1);
                                snapshot.data!.results.addAll(results);
                              });
                            },
                            controller: _controllerSearch,
                            decoration: InputDecoration(
                              labelText: 'Search', suffixIcon: Icon(Icons.search)
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              searchPokemon(snapshot.data!.results);
                            },
                            icon: Icon(
                              Icons.search,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        shrinkWrap: true, 
                        itemBuilder: (BuildContext context, index){
                          if (snapshot.data!.results.length == index)
                            return Center(
                              child: CircularProgressIndicator()
                          );
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => DetailScreen(url : snapshot.data!.results[index].url)),
                              );
                            },
                            child: GridTile(
                              // header: Center(
                              //   child: Text(
                              //     snapshot.data!.results[index].name
                              //   ),
                              // ),
                              child: Text(
                                snapshot.data!.results[index].name
                              ),
                              //Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png'),
                              // footer: Container(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //     children: <Widget>[
                              //       Column(
                              //         children: <Widget>[
                              //           Text('Type'),
                              //           Container(
                              //             color: Colors.brown,
                              //             child: Text('Ground'),
                              //           ),
                              //         ],
                              //       ),
                              //       Column(
                              //         children: <Widget>[
                              //           Text('Abilities'),
                              //           Text('overgrow'),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ),
                          );
                        },
                        itemCount: _isLoading ? snapshot.data!.results.length + 1 : snapshot.data!.results.length ,
                      ),
                    ),
                      ElevatedButton(
                        onPressed: (){
                          loadMorePokemon(snapshot.data!.next, snapshot.data!.results);
                        },
                        child: Text('Load More Data')
                      ),
                  ],
                ),
              );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return CircularProgressIndicator();
        }
      ),
    );
  }

  Future<AllPokemon> getAllPokemon() async {
    var response = 
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?offset=40&limit=20'));

    if (response.statusCode == 200) {
      //print(AllPokemon.fromJson(jsonDecode(response.body)).next);
      return AllPokemon.fromJson(jsonDecode(response.body));

    }else {
      print('erros');
      throw Exception('Failed load data');
    }
  }

  Future loadMorePokemon(String url, List<Result> data) async {
    var response = 
    await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      setState(){
        data.addAll(AllPokemon.fromJson(jsonDecode(response.body)).results);
      }
    }else {
      print('errors');
      throw Exception('Failed load data');
    }
}

  Future searchPokemon(List<Result> data) async{
    var enteredKeyword = _controllerSearch.text;
    var response = 
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$enteredKeyword/'));

    if (response.statusCode == 200) {
      List<Result> results = [];
      if (enteredKeyword.isEmpty) {
        /// if the search field is empty or only contains white-space, we'll display all users
        results = data;
      } else {
        results = data
          .where((a) =>
              a.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      }
      /// Refresh the UI
      setState(() {
        data.removeRange(0, data.length-1);
        data.addAll(results);
      });
    }else {
      throw Exception('Failed load data');
    }
  }

}


