import 'dart:math';

import 'package:anilist_movie_flutter/data/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:transparent_image/transparent_image.dart';

class AnimeDetail extends StatelessWidget {
  static Color randomOpaqueColor() {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
  }

  final MovieModel anime;

  const AnimeDetail({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (anime.title != null) ...[
              Text(
                anime.title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
            if (anime.coverImage != null) ...[
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: FadeInImage.memoryNetwork(
                  height: 200,
                  placeholder: kTransparentImage,
                  image: anime.coverImage!,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
            if (anime.season != null &&
                anime.seasonYear != null &&
                anime.status != null &&
                anime.episodes != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${anime.season!}-",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "${anime.seasonYear!}-",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "${anime.status!}-",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${anime.episodes ?? 0} episodes",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
            if (anime.genres != null || anime.genres!.isNotEmpty) ...[
              Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    for (var i = 0; i < anime.genres!.length; i++) ...[
                      Text(
                        '${i != 0 ? "," : ""}${anime.genres![i]}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: randomOpaqueColor(),
                        ),
                      )
                    ]
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
            if (anime.description != null) ...[
              SingleChildScrollView(
                child: Html(
                  data: anime.description!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
