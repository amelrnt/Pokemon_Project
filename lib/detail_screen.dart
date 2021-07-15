import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon/model/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pokemon/model/bookmark.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({ Key? key, required this.url }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<PokemonDetails>(
          future: getPokemon(url),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              return 
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(snapshot.data!.name + ' #' + snapshot.data!.id.toString() ),
                      BookmarkButton(name: snapshot.data!.name, url: url),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.network(snapshot.data!.sprites.frontDefault),
                      //Text('DescriptionDescription\nDescription'),
                      Text(snapshot.data!.baseExperience.toString()),
                      //Text(snapshot.data!.baseExperience.toString()?? 'null'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    // TODO: Loop here for stat
                                    //Textsnapshot.data!.stats.map((e) => new Text(e.stat.name));
                                    Text('HP'),
                                    Text('Attack'),
                                    Text('Defense'),
                                    Text('Special-attack'),
                                    Text('Special-defense'),
                                    Text('Speed'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    // TODO: Loop here for stat
                                    Text(snapshot.data!.stats[0].baseStat.toString()),
                                    Text('42'),
                                    Text('49'),
                                    Text('45'),
                                    Text('42'),
                                    Text('49'),
                                  ],
                                ),
                              ],
                            ),
                            color: Colors.yellowAccent,
                          ),    
                          Container(
                            child: Row(
                              children: [
                                Column(
                                  children: <Widget>[
                                    Text('Height'),
                                    Text(snapshot.data!.height.toString()+ '\''),
                                    Text('Weight'),
                                    //Text(snapshot.data!=null?snapshot.data!.weight.toString():'default value'),
                                    Text(snapshot.data!.weight.toString()+ ' lbs'),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    // TODO: Map abilities here
                                    Text('Ability'),
                                    //Text(snapshot.data!=null?snapshot.data!.abilities[0].ability.name:'default value'),
                                    Text(snapshot.data!.abilities[0].ability.name),
                                    Text('Hidden Ability'),
                                    //Text(snapshot.data!=null?snapshot.data!.abilities[1].ability.name:'default value'),
                                    Text(snapshot.data!.abilities[1].ability.name),
                                  ],
                                ),
                              ],
                            ),
                            color: Colors.blueAccent,
                          ),
                        
                        ],
                      ),
                      Text('Types'),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // TODO : loop here for types
                            Container(
                              child: 
                              //Text(snapshot.data!=null?snapshot.data!.types[0].type.name:'default value'),
                              Text(snapshot.data!.types[0].type.name),
                              color: Colors.yellowAccent,
                            ),
                            // Container(
                            //   child: Text(snapshot.data!.types[1].type.name),
                            //   color: Colors.cyanAccent,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator();
          }
        ),
      ),
    );
  }

  Future<PokemonDetails> getPokemon(String url) async{
    var response = await http.get(Uri.parse(url)).timeout(const Duration());
    print('test');
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return PokemonDetails.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load data');
    }
  }
}


class BookmarkButton extends StatefulWidget {
  final String name;
  final String url;

  const BookmarkButton({ Key? key, required this.name, required this.url}) : super(key: key);

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool isBookmarked = false;
  
  void bookmarkCheck () {
    for (var element in bookmarkList) {
      if (element.name == widget.name) {
        isBookmarked = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isBookmarked ? Icons.bookmark_added : Icons.bookmark_border ,
      ),
      onPressed: (){
        bookmarkCheck();
        setState(() {
          isBookmarked = !isBookmarked;
          if (isBookmarked) {
            bookmarkList.add(new Bookmarks(name: widget.name, url: widget.url));
            final snackBar = SnackBar(
            content: Text('Bookmarked'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }else if(!isBookmarked) {
            bookmarkList.remove(Bookmarks(name: widget.name, url: widget.url));
            final snackBar = SnackBar(
            content: Text('Unbookmarked'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
        
      },
    );
  }
}