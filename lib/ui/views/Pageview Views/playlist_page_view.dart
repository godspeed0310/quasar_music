import 'dart:ffi';

import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
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
import 'package:quasar_music/models/song_model.dart' as sm;

class PlaylistPageView extends StatefulWidget {
  @override
  State<PlaylistPageView> createState() => _PlaylistPageViewState();
}

class _PlaylistPageViewState extends State<PlaylistPageView> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final FirestoreService _firestoreService = locator<FirestoreService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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

          return songs.length > 0
              ? Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: CustomScrollView(
                      slivers: [
                        const SliverPadding(
                          padding: EdgeInsets.only(
                              top: 70, bottom: 20, left: 12, right: 12),
                          sliver: SliverToBoxAdapter(
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
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, int index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SongView(
                                        song: sm.SongModel.fromMap(
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
                            childCount: songs.length,
                          ),
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.only(
                              top: 30, left: 12, right: 12, bottom: 20),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              'Your playlists',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: StreamBuilder(
                            stream: _firestoreService.userRef
                                .doc(_authenticationService.currentUser.uid)
                                .collection('playlists')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(primaryColor),
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                var playlistDoc = snapshot.data;

                                return ListView(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  children: playlistDoc!.docs.map(
                                    (document) {
                                      var playlistDoc = document.data();
                                      var playlistSongs =
                                          (playlistDoc as Map)['songs'];

                                      return ListTile(
                                        leading: playlistSongs == [] ||
                                                playlistSongs == '' ||
                                                playlistSongs == null
                                            ? Container(
                                                height: 50,
                                                width: 50,
                                                child: CachedNetworkImage(
                                                    imageUrl:
                                                        'http://www.scottishculture.org/themes/scottishculture/images/music_placeholder.png'),
                                              )
                                            : Container(
                                                height: 50,
                                                width: 50,
                                                child: CachedNetworkImage(
                                                  imageUrl: playlistSongs[0]
                                                      ['artworkRawUrl'],
                                                ),
                                              ),
                                        subtitle: const Text(
                                          'Created by you',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        title: Text(
                                          document['name'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                );
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(primaryColor),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: Text('No data found'),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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
                )
              : Scaffold(
                  body: SizedBox.expand(
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
                );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('No data found'),
            ),
          );
        }
      },
    );
  }
}
