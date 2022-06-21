import 'package:flutter/material.dart';

class favoriteButton extends StatefulWidget {
  @override
  State<favoriteButton> createState() => _favoriteButtonState();
}

bool _isFavorite = true;

class _favoriteButtonState extends State<favoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      left: 80,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: .8,
              offset: Offset(.0, 1.5),
            ),
          ],
        ),
        child: IconButton(
          constraints: BoxConstraints(maxHeight: 35, maxWidth: 35),
          onPressed: () async {
            print(_isFavorite);
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
          iconSize: 20,
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.redAccent[400],
          ),
        ),
      ),
    );
  }
}
