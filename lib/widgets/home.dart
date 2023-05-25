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

  ];

  var searchTextEditingController = TextEditingController();

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
                    controller: searchTextEditingController,
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
                      fetchMovieSearch(searchTextEditingController.text).then((value) => {
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
  Future<List<MovieSearch>> fetchMovieSearch(searchText) async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?s=$searchText&apikey=87d10179'));

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
