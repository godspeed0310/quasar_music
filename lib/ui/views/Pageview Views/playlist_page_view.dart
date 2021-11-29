import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quasar_music/locator.dart';
import 'package:quasar_music/services/authentication_service.dart';
import 'package:quasar_music/ui/shared/app_colors.dart';

class PlaylistPageView extends StatelessWidget {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> favStream = FirebaseFirestore.instance
        .collection('users')
        .doc(_authenticationService.currentUser.uid)
        .snapshots();

    return StreamBuilder(
      stream: favStream,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primaryColor),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'An error occured',
              ),
            ),
          );
        } else if (snapshot.hasData) {
          var songDoc = snapshot.data!.data();
          var songs = (songDoc as Map)['favourites'];

          return ListView.builder(
            itemCount: songs != null ? songs.length : 0,
            itemBuilder: (_, int index) {
              return ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  child: CachedNetworkImage(
                    imageUrl: songs[index]['artworkRawUrl'],
                  ),
                ),
                title: Text(
                  songs[index]['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  songs[index]['artistName'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              );
            },
          );
        } else {
          return SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: 250,
                  child: SvgPicture.asset(
                    'lib/assets/images/no_music_illustration.svg',
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'No playlists found on your account.\nCreate a new playlist to see it here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
