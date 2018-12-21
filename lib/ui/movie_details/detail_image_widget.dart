import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailImageWidget extends StatelessWidget {
  final int _index;
  final String _imageURL;
  final String _imageCaption;
  final String heroTag;

  Function(int) callback;

  DetailImageWidget(this._imageURL, this._imageCaption, this._index,
      {this.heroTag, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: new BorderRadius.circular(8.0),
                    child: Hero(
                      tag: heroTag ?? _imageCaption,
                      child: CachedNetworkImage(
                        imageUrl: _imageURL,
                        //placeholder: ,
                      ),
                    )),
                Positioned.fill(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      splashColor: Colors.redAccent,
                      onTap: () {
                        if (callback != null) callback(_index);
                      }),
                )),
              ],
            ),
          ),
          Text(
            _imageCaption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
