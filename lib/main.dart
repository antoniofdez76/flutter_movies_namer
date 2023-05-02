import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http;
import 'package:flutter_movies_namer/config.dart';



void main() {
  runApp(MyApp());
}




class Movie {
  final String title;
  final String image;
  final String description;

  Movie(this.title, this.image, this.description);
}

class MovieListPage extends StatelessWidget {
  final List<Movie> movies;

  const MovieListPage({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Películas'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(10.0),
            height: 150.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Image.network(
                    movies[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          movies[index].title,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          movies[index].description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Character {
  final String name;
  final String description;
  final String thumbnail;

  Character(this.name, this.description, this.thumbnail);
}

class CharacterListPage extends StatefulWidget {
  @override
  _CharacterListPageState createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  List<Character> characters = [];

  Future<void> fetchCharacters() async {
    final apiKey = 'd16899700e714360a6f765b408d942bb';
    final url =
        'https://gateway.marvel.com/v1/public/characters?apikey=$apiKey';
    final response = await http.get(Uri.parse(url));

    final decoded = json.decode(response.body);
    final results = decoded['data']['results'];

    setState(() {
      characters = results
          .map((result) => Character(
        result['name'],
        result['description'],
        '${result['thumbnail']['path']}.${result['thumbnail']['extension']}',
      ))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personajes de Marvel'),
      ),
      body: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (BuildContext context, int index) {
          final character = characters[index];

          return ListTile(
            leading: Image.network(character.thumbnail),
            title: Text(character.name),
            subtitle: Text(character.description),
          );
        },
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  final List<Movie> movies = [    Movie(      'Pelicula 1',      'https://picsum.photos/id/5/200/300',      'Descripción.',    ),    Movie(      'Pelicula 2',      'https://picsum.photos/id/2/200/300',      'Descripción.',    ),    Movie(      'Pelicula 3',      'https://picsum.photos/id/3/200/300',      'Descripción.',    ),  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello World'),
            Image.network(
              'https://picsum.photos/id/870/200/300?grayscale&blur=2',
              fit: BoxFit.cover,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieListPage(
                      movies: movies,
                    ),
                  ),
                );
              },
              child: Text('Ver películas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CharacterListPage(),
                  ),
                );
              },
              child: Text('Ver personajes'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Películas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}

class PersonajesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personajes'),
      ),
      body: Center(
        child: Text('Aquí puedes mostrar la lista de personajes'),
      ),
    );
  }
}
