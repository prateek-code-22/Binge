import 'dart:ui';

import 'package:binge/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieDetailPage extends StatelessWidget {
  //const MovieDetailPage({Key key}) : super(key: key);

  final Movie movie;
  MovieDetailPage(this.movie);

  Future bgLoad() async {
    await Future.delayed(Duration(seconds: 2));
  }

  bgposter() {
    final String imgbg = 'https://image.tmdb.org/t/p/w500/';
    String img;
    if (imgbg != null) {
      img = imgbg + movie.posterPath;
    } else {
      img =
          'https://askleo.askleomedia.com/wp-content/uploads/2004/06/no_image-300x245.jpg';
    }

    return img;
  }

  posterPath() {
    final String imgPath = 'https://image.tmdb.org/t/p/w200/';
    String path;
    if (imgPath != null) {
      path = imgPath + movie.posterPath;
    } else {
      path =
          'https://askleo.askleomedia.com/wp-content/uploads/2004/06/no_image-300x245.jpg';
    }
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //BACKGROUND BLUR CONTAINER

            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                bgposter(),
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3.0,
                  sigmaY: 3.0,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white.withOpacity(0),
                ),
              ),
            ),

            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //MOVIE POSTER CONTAINER
                  Card(
                    shadowColor: Colors.white,
                    elevation: 10.0,
                    child: Image.network(
                      posterPath(),
                    ),
                  ).p32(),

                  //CONTAINER FOR MOVIE TITLE
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blueGrey,
                    ),
                    child: Text(
                      movie.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                      ),
                    ).p12(),
                  ).px20(),

                  SizedBox(
                    height: 20,
                  ),
                  //CARD CONTAINS MOVIE OVERVIEW
                  Card(
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 2.0,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Text(
                          movie.overview,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: Colors.white,
                          ),
                        ).p20(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Released Date: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              movie.releaseDate.toString(),
                              style: TextStyle(
                                color: Colors.amber[600],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ).pOnly(left: 22.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Vote: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              movie.voteAverage.toString(),
                              style: TextStyle(
                                color: Colors.amber[600],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ).p4().pOnly(bottom: 8, left: 20),
                      ],
                    ),
                  ).pOnly(
                    top: 18.0,
                    left: 18.0,
                    right: 18.0,
                    bottom: 18.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
