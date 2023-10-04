import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:subspaceblogs/blog_detail.dart';

class BlogItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String id;

  BlogItem({required this.imageUrl, required this.title , required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BlogDetail(
            imageUrl: imageUrl,
            title: title,
            id: id,

          ),
        ),
      );},
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white24,
            ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,

                //height: 200,
                placeholder: (context, url) {
                  return SizedBox(
                    child: const CircularProgressIndicator(
                    color: Colors.white,),
                    width: 30,
                    height: 30,
                  );
                },
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
      ),
            Padding(padding: EdgeInsets.all(10),child: Text(title , style: TextStyle(fontFamily: "Times New Roman" , fontSize: 15),textAlign: TextAlign.center,))

          ],
        ),
      ),
    );;
  }
}
