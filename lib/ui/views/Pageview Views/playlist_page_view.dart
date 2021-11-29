import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quasar_music/locator.dart';
import 'package:quasar_music/models/song_model.dart';
import 'package:quasar_music/services/authentication_service.dart';
import 'package:quasar_music/services/firestore_service.dart';
import 'package:quasar_music/ui/shared/app_colors.dart';
import 'package:quasar_music/ui/views/song_view.dart';

class PlaylistPageView extends StatefulWidget {
  @override
  State<PlaylistPageView> createState() => _PlaylistPageViewState();
}

class _PlaylistPageViewState extends State<PlaylistPageView> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final FirestoreService _firestoreService = locator<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> favStream = FirebaseFirestore.instance
        .collection('users')
        .doc(_authenticationService.currentUser.uid)
        .snapshots();
    TextEditingController inputController = TextEditingController();

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

          return SafeArea(
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Your favourites',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 14,
                    child: ListView.builder(
                      itemCount: songs != null ? songs.length : 0,
                      itemBuilder: (_, int index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SongView(
                                  song: SongModel.fromMap(
                                    songs[index],
                                  ),
                                ),
                              ),
                            );
                          },
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
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Create a new playlist'),
                      content: TextField(
                        controller: inputController,
                        decoration: const InputDecoration(
                          hintText: 'Name your playlist',
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _firestoreService.createPlaylist(
                              inputController.text,
                              _authenticationService.currentUser.uid,
                            );
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'OK',
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Icon(
                  EvaIcons.plus,
                  color: Colors.white,
                ),
              ),
            ),
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
