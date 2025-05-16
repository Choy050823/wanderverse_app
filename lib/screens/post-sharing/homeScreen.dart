import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanderverse_app/utils/widgets/postCard.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String creatorId = "choymh23";
  String destination = "NUS";
  int initialLikes = 123;
  String imageUrl =
      "https://m.media-amazon.com/images/I/71eYCAMKcJL._AC_UF1000,1000_QL80_.jpg";
  String profilePicUrl =
      "https://media.licdn.com/dms/image/v2/D5603AQHGl9U2jctJ0Q/profile-displayphoto-shrink_400_400/B56ZTJkMWIGQAo-/0/1738548496286?e=1752710400&v=beta&t=RPWykSYhW9Ek6yXupsn9QUQICrY8LUlPLG-cIk_8G6E";
  String caption = "Japan is fun";

  late final List<Map<String, dynamic>> posts;

  @override
  void initState() {
    super.initState();
    posts = List.generate(
        20,
        (index) => {
              'creatorId': creatorId,
              'destination': destination,
              'initialLikes': initialLikes,
              'imageUrl': imageUrl,
              'profilePicUrl': profilePicUrl,
              'caption': caption,
              'height': 500 + Random().nextInt(200)
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MasonryGridView.count(
            itemCount: 20,
            crossAxisCount: 4,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(
                creatorId: post['creatorId'],
                destination: post['destination'],
                initialLikes: post['initialLikes'],
                imageUrl: post['imageUrl'],
                profilePicUrl: post['profilePicUrl'],
                caption: post['caption'],
                height: post['height'],
              );
            }),
      ),
    );
  }
}
