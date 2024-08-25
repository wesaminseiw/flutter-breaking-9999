import 'package:flutter/material.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/constants/strings.dart';
import 'package:flutter_breaking/data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charactersDetailsScreen, arguments: character),
        child: GridTile(
          footer: Hero(
            tag: character.id,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16.0,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: MyColors.myGrey,
            child: character.image.isNotEmpty
            ? FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: character.image,
              fit: BoxFit.cover,
            )
            : Image.asset('assets/images/placeholder.jpg'),
          ),
        ),
      ),
    );
  }
}


