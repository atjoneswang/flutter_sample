import 'package:meta/meta.dart';

class Artist{

  final String firstName;
  final String lastName;
  final String avatar;
  final String backdropPhoto;
  final String location;
  final String biography;
  final List<Video> videos;

  Artist({
    @required this.firstName,
    @required this.lastName,
    @required this.avatar,
    @required this.backdropPhoto,
    @required this.location,
    @required this.biography,
    @required this.videos
  });


}

class Video {
  final String title;
  final String thumbnail;
  final String url;

  Video({
    @required this.title,
    @required this.thumbnail,
    @required this.url
  });
}

final Artist andy = new Artist(
    firstName: "Andy",
    lastName: "Fraser",
    avatar: "assets/images/avatar.png",
    backdropPhoto: "assets/images/backdrop.png",
    location: "London, England",
    biography: 'Andrew McLan "Andy" Fraser was an English songwriter and bass '
        'guitarist whose career lasted over forty years, and includes two spells '
        'as a member of the rock band Free, which he helped found in 1968, aged 15.',
    videos: videos);

final List<Video> videos = [
  Video(
    title: 'Free - Mr. Big - Live at Granada Studios 1970',
    thumbnail: 'assets/images/video1_thumb.png',
    url: 'https://www.youtube.com/watch?v=_FhCilozomo',
  ),
  Video(
    title: 'Free - Ride on a Pony - Live at Granada Studios 1970',
    thumbnail: 'assets/images/video2_thumb.png',
    url: 'https://www.youtube.com/watch?v=EDHNZuAnBoU',
  ),
  Video(
    title: 'Free - Songs of Yesterday - Live at Granada Studios 1970',
    thumbnail: 'assets/images/video3_thumb.png',
    url: 'https://www.youtube.com/watch?v=eI1FT0a_bos',
  ),
  Video(
    title: 'Free - I\'ll Be Creepin\' - Live at Granada Studios 1970',
    thumbnail: 'assets/images/video4_thumb.png',
    url: 'https://www.youtube.com/watch?v=3qK8O3UoqN8',
  ),
];