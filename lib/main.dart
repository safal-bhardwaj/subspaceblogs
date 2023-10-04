
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:subspaceblogs/FavScreen.dart';
import 'package:subspaceblogs/blog_item.dart';

// global blog list

List<dynamic> blogs = [];
String errormessage = "";

//blog fetching from API
Future<void> fetchBlogs() async {
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    if (response.statusCode == 200) {
      // Request successful, handle the response data here
      blogs = jsonDecode(response.body)["blogs"];
      //print('Response data: ${blogs}');
    } else {
      // Request failed
      print('Request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');
      errormessage = "We ran into some problem! Get back in sometime";
    }
  } catch (e) {
    // Handle any errors that occurred during the request
    print('Error: $e');
    errormessage = "Something went wrong! \n Please restart the app or check your network connection ";
  }
}

void main() async {
  await fetchBlogs();

  runApp(ProviderScope(
    child: MaterialApp(
      theme: ThemeData.dark(),
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assests/images/subspace_hor.png",
                width: 150,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context)=>
                        FavScreen(
                          blogs: blogs,
                        )
                      ));
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.black45,
                    ),
                  ))
            ],
          ),
        ),
        body: errormessage.isNotEmpty ?
        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline , color: Colors.white10,size: 200,),
            Text(errormessage, style: const TextStyle(fontFamily: "Times New Roman", color: Colors. white54),textAlign: TextAlign.center,)
          ],
        ),) : FutureBuilder(
            //future: fetchBlogs(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  return BlogItem(
                    imageUrl: blogs[index]["image_url"],
                    title: blogs[index]["title"],
                    id: blogs[index]["id"],
                  );
                },
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.chat),
          backgroundColor: Colors.white,
        ),
      );
  }
}
