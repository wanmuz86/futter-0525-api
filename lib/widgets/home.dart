import 'package:flutter/material.dart';
import 'package:movie_app3/movie_search.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// stful + home (HomePage)
// stful + detail (DetailPage)
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var movies = [
    // {
    //   "Title": "The Lord of the Rings: The Fellowship of the Ring",
    //   "Year": "2001",
    //   "imdbID": "tt0120737",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "The Lord of the Rings: The Return of the King",
    //   "Year": "2003",
    //   "imdbID": "tt0167260",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BNzA5ZDNlZWMtM2NhNS00NDJjLTk4NDItYTRmY2EwMWZlMTY3XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "The Lord of the Rings: The Two Towers",
    //   "Year": "2002",
    //   "imdbID": "tt0167261",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BZGMxZTdjZmYtMmE2Ni00ZTdkLWI5NTgtNjlmMjBiNzU2MmI5XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "The Lord of the Rings: The Rings of Power",
    //   "Year": "2022–",
    //   "imdbID": "tt7631058",
    //   "Type": "series",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BNTg3NjcxYzgtYjljNC00Y2I2LWE3YmMtOTliZTkwYTE1MmZiXkEyXkFqcGdeQXVyNTY4NDc5MDE@._V1_SX300.jpg"
    // }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Movie app")),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: "Enter movie to search"),
                  ),
                  flex: 2,
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    style: const ButtonStyle(

                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    onPressed: () {
                      fetchMovieSearch().then((value) => {
                        setState((){
                          movies=value;
                        })
                      });
                    },
                    child: Text("Search", style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: movies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(movies[index].title),
                      subtitle: Text(movies[index].year),
                      leading: Image.network(movies[index].posterUrl),
                      trailing: Icon(Icons.chevron_right),
                    );
                  }),
            )
          ],
        ));
  }
// What is the data type ? => MovieSearch
  // Is it a List or object => List<MovieSearch> (Data type if have List)
  Future<List<MovieSearch>> fetchMovieSearch() async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?s=Lord&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieSearch.moviesFromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
