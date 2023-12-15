import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'users_model.dart';

class mainscreenn extends StatefulWidget {
  const mainscreenn({Key? key}) : super(key: key);

  @override
  State<mainscreenn> createState() => _mainscreennState();
}

class _mainscreennState extends State<mainscreenn> {
  final String url_ = 'https://randomuser.me/api/?results=100';
  Users users = Users(results: []);

  // List of colors for user backgrounds
  final List<Color> userColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Center(
          child: Text(
            'List of Users',
            style: TextStyle(
              fontFamily: 'fontik/fontik1.ttf',
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: users.results.length,
        itemBuilder: (context, index) {
          final Result user = users.results[index];
          final Color userColor = userColors[index % userColors.length];

          return Container(
            color: userColor,
            padding: const EdgeInsets.all(8.0), // Add padding between items
            margin: const EdgeInsets.symmetric(
                vertical: 8.0), // Add margin between items
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(user.picture.thumbnail),
              ),
              title: Text(
                '${user.name.first} ${user.name.last}',
                style: const TextStyle(
                  fontFamily: 'fontik/fontik1.ttf',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                user.email,
                style: const TextStyle(
                  fontFamily: 'fontik',
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: fetch,
        child: const Icon(
          Icons.system_update_alt,
          color: Colors.white,
        ),
      ),
    );
  }

  void fetch() async {
    final response = await http.get(Uri.parse(url_));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> results = jsonData['results'];

      final List<Result> converted = results.map((user) {
        return Result(
          gender: user['gender'],
          name: Name(
            title: user['name']['title'],
            first: user['name']['first'],
            last: user['name']['last'],
          ),
          email: user['email'],
          phone: user['phone'],
          picture: Picture(
            thumbnail: user['picture']['thumbnail'],
          ),
        );
      }).toList();

      setState(() {
        users = Users(results: converted);
      });
    }
  }
}
