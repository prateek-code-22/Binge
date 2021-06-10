import 'package:binge/http_helper.dart';
import 'package:binge/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text(
    'Binge',
    style: TextStyle(
      color: Colors.red,
      fontSize: 30,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  ).p8();

  HttpHelper helper;
  int movieCount;
  List movies;

  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://askleo.askleomedia.com/wp-content/uploads/2004/06/no_image-300x245.jpg';

  Future initialize() async {
    movies = [];
    movies = await helper.getUpcoming();
    setState(() {
      movieCount = movies.length;
      movies = movies;
    });
  }

  Future search(text) async {
    await Future.delayed(Duration(seconds: 2));
    movies = await helper.findMovies(text);
    setState(() {
      movieCount = movies.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          elevation: 3.0,
          shadowColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (this.visibleIcon.icon == Icons.search) {
                    this.visibleIcon = Icon(Icons.cancel_sharp);
                    this.searchBar = TextField(
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      onSubmitted: (String text) {
                        search(text);
                      },
                    ).p4();
                  } else {
                    setState(() {
                      this.visibleIcon = Icon(Icons.search);
                      this.searchBar = Text(
                        'Binge',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ).p8();
                    });
                  }
                });
              },
              icon: visibleIcon,
              iconSize: 30.0,
              color: Colors.red,
            ).px8(),
          ],
          title: searchBar,
        ),
        body: (movies != null && movies.isNotEmpty)
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: (this.movieCount == null) ? 0 : movieCount,
                itemBuilder: (BuildContext context, int position) {
                  if (movies[position].posterPath != null) {
                    image =
                        NetworkImage(iconBase + movies[position].posterPath);
                  } else {
                    image = NetworkImage(defaultImage);
                  }

                  return InkWell(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (_) => MovieDetailPage(movies[position]),
                      );
                      Navigator.push(context, route);
                    },
                    child: Card(
                      color: Colors.grey[900],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: GridTile(
                        child: Stack(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.grey[900],
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Image(
                                image: image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              height: 40.0,
                              width: 240.0,
                              color: Colors.grey[900],
                              child: Text(
                                movies[position].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16.0,
                                ),
                              ).p12(),
                            ),
                          ],
                        ),
                      ),
                    ).p8(),
                  );
                },
              ).p16().pOnly(top: 16.0)
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
