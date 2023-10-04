import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:subspaceblogs/FavProvider.dart';

import 'blog_item.dart';

class FavScreen extends ConsumerStatefulWidget{
  List<dynamic> blogs ;
  FavScreen({super.key,required this.blogs});

  @override
  ConsumerState<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends ConsumerState<FavScreen> {
  @override
  Widget build(BuildContext context) {
    var favBlogs = ref.watch(favProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(
        "Favorites",
      ),),
      body: ListView.builder( itemCount: widget.blogs.length ,itemBuilder:(context,index)
      {
         if(favBlogs.contains(widget.blogs[index]["id"]))
           {return BlogItem(imageUrl: widget.blogs[index]["image_url"],
          title: widget.blogs[index]["title"],
          id: widget.blogs[index]["id"],);}
         else
           {
             return SizedBox(width: 0 , height: 0,);
           }
      }),
    );
  }
}
