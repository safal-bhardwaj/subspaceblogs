import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'FavProvider.dart';
import 'package:riverpod/riverpod.dart';
import 'FavProvider.dart';

class BlogDetail extends ConsumerStatefulWidget {
  final String imageUrl;
  final String title;
  final String id;

  BlogDetail({required this.imageUrl, required this.title, required this.id});

  @override
  ConsumerState<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends ConsumerState<BlogDetail> {
  @override
  Widget build(BuildContext context) {
    var favoriteBlogs = ref.watch(favProvider);
    var isFavorite = favoriteBlogs.contains(widget.id);

    void markFavorite() {
      if (isFavorite) {
        favoriteBlogs.remove(widget.id);
        setState(() {
          isFavorite = false;
        });
      } else {
        favoriteBlogs.add(widget.id);
        setState(() {
          isFavorite = true;
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title.length > 20
                    ? widget.title.substring(0, 20) + " ..."
                    : widget.title,
                textAlign: TextAlign.left,
              ),
              IconButton(
                  onPressed: markFavorite,
                  icon: isFavorite
                      ? Icon(Icons.favorite)
                      : Icon(
                          Icons.favorite_border,
                        ))
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return const CircularProgressIndicator(
                    color: Colors.white,
                  );
                },
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 20, fontFamily: "Times New Roman"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Nothing to show",
                    style:
                        TextStyle(fontSize: 16, fontFamily: "Times New Roman"),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
