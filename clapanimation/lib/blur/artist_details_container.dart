import 'package:flutter/material.dart';
import '../models/blur/models.dart';
import 'artist_details_page.dart';

class ArtistsDetailsAnimator extends StatefulWidget {
  @override
  _ArtistsDetailsAnimatorState createState() => _ArtistsDetailsAnimatorState();
}

class _ArtistsDetailsAnimatorState extends State<ArtistsDetailsAnimator> with SingleTickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200)
    );

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ArtistDetailsPage(artist: andy,controller: _controller,);
  }
}
