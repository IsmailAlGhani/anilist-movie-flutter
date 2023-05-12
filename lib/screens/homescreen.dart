import 'dart:async';

import 'package:anilist_movie_flutter/constants.dart';
import 'package:anilist_movie_flutter/data/models/data.dart';
import 'package:anilist_movie_flutter/widgets/genre_text_field.dart';
import 'package:anilist_movie_flutter/widgets/list_anime.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(
        seconds: 1,
      ),
      vsync: this,
    );
    animation = ColorTween(
      begin: Colors.blueGrey,
      end: Colors.white,
    ).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<Data>().updateSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 48.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    const Hero(
                      tag: "logo",
                      child: SizedBox(
                        height: 60.0,
                        child: Icon(
                          Icons.tv_sharp,
                          size: 60.0,
                        ),
                      ),
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Anime Movie',
                          textStyle: const TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextField(
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                onChanged: _onSearchChanged,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Search your Anime'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const GenreTextField(),
              const SizedBox(
                height: 24.0,
              ),
              ListAnime(),
            ],
          ),
        ),
      ),
    );
  }
}
