

// If you want to recap this part, check with book / pdf chapter 3 on OOP
// 1) Class Declaration
class MovieSearch {

  // 2) Property declaration

  String title;
  String imdbId;
  String posterUrl;
  String year;
  String type;

  // 3) Declare the constructor

  MovieSearch(
      {required this.title, required this.imdbId, required this.posterUrl, required this.year,
        required this.type});


// 4) Create JSON to Class Mapper

  factory MovieSearch.fromJson(Map<String, dynamic> json) {
    return MovieSearch(
        title: json['Title'],
        imdbId: json['imdbID'],
        posterUrl: json['Poster'],
        year: json['Year'],
        type: json['Type']
    );
  }
// 5) Array to List of JSON transformer
  static List<MovieSearch> moviesFromJson(dynamic json ){
    var searchResult = json["Search"];
    List<MovieSearch> results = new List.empty(growable: true);

    if (searchResult != null){

      searchResult.forEach((v)=>{
        results.add(MovieSearch.fromJson(v))
      });
      return results;
    }
    return results;
  }

}