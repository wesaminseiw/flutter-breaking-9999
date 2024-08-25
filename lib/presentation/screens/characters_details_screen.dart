import 'package:flutter/material.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import '../../data/models/characters.dart';

class CharactersDetailsScreen extends StatelessWidget {
  const CharactersDetailsScreen({super.key, required this.character});

  final Character character;

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 650,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String content) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: content,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16.0,
            ),
          ),
        ]
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 20,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14,14,14,0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo('Status: ', character.status),
                  buildDivider(310),
                ],
              ),
            ),
            SizedBox(height: 700,),
          ])),
        ],
      ),
    );
  }
}
