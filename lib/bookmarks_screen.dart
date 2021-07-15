import 'package:flutter/material.dart';
import 'package:flutter_pokemon/detail_screen.dart';
import 'package:flutter_pokemon/model/bookmark.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
          ),
          itemCount: bookmarkList.length, 
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => DetailScreen(url: bookmarkList[index].url)),
                );
              },
              child: GridTile(
                header: Center(
                  child: Text(bookmarkList[index].name),
                  ),
                child: Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png'),
                footer: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('Type'),
                          Container(
                            color: Colors.brown,
                            child: Text('Ground'),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('Abilities'),
                          Text('overgrow'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}