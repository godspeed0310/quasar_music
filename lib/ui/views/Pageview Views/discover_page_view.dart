import 'package:flutter/material.dart';
import 'package:quasar_music/ui/widgets/music_widget.dart';

class DiscoverPageView extends StatelessWidget {
  const DiscoverPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 100,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'New releases',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'The best new releases',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: const [
                  MusicWidget(),
                  MusicWidget(),
                  MusicWidget(),
                  MusicWidget(),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'New albums & singles',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              childAspectRatio: 0.75,
              crossAxisCount: 2,
              children: const [
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
                MusicWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
