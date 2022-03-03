import 'package:flutter/material.dart';
import '../../constansts/my_colors.dart';
import '../../constansts/strings.dart';

import '../../data/models/charachters.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          charachtersDetailsScreen,
          arguments: character,
        ),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              color: MyColors.myGrey,
              child: character.img.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/93486-load.gif',
                      image: character.img,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/placeholder.png'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style: const TextStyle(
                height: 1.3,
                fontSize: 16,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
