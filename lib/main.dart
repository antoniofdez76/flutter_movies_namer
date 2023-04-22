import 'package:flutter/material.dart';

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
