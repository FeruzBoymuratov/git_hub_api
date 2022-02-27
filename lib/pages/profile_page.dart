
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_hub_api/services/http_service.dart';
import 'package:line_icons/line_icons.dart';

import '../services/http_service.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final _userController = TextEditingController();

  Map<String, dynamic> resBody = {};
  String userInput = '';
  @override
  void initState() {
    super.initState();

    _apiProfileGet();
  }

  void _apiProfileGet() {
    Network.GET(Network.API_GET).then((response) {
      setState(() {
        resBody = jsonDecode(response.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Text('/${resBody["login"] ?? '...'}', style: const TextStyle(color: Colors.white30, fontSize: 20),),

          Container(
            padding: EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/3),
            color: const Color(0xFF171b21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("GitHub", style: TextStyle(color: Colors.grey, fontSize: 50, fontWeight: FontWeight.bold),),
                Text(".com", style: TextStyle(color: Colors.grey, fontSize: 50),),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
            padding: const EdgeInsets.only(top: 150),
            color: Colors.black,
            child: _widget(),
          ),

          Container(
            margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height/5)-12.5, left: (MediaQuery.of(context).size.width/4)-12.5),
            height: 225,
            width: 225,
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/5, left: MediaQuery.of(context).size.width/4),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(resBody['avatar_url'] ?? 'https://chonjiacademy.com/wp-content/uploads/2017/04/default-image-620x600.jpg'), fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LineIcons.link, color: Colors.grey, size: 20,),
            const SizedBox(width: 5,),
            Text('${resBody["url"] ?? '...'}', style: const TextStyle(color: Colors.white30, fontSize: 15,), textAlign: TextAlign.center,),
          ],
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const Icon(Icons.account_circle, color: Colors.grey, size: 40,),
            const SizedBox(width: 10,),
                  
                  Expanded(
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade900,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        style: TextStyle(color: Colors.grey),
                        showCursor: true,
                        controller: _userController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username ni kiriting!',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 2),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.check, color: Colors.grey,),
                      onPressed: (){

                        setState(() {
                          _userController.text.trim();
                          userInput = '/users/'+_userController.text;
                          Network.API_GET = userInput;
                          print(userInput);
                        });
                      },
                    ),
                  ),
            const SizedBox(width: 10,),
          ],
        ),
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 20,),
            const Icon(LineIcons.wiredNetwork, color: Colors.grey, size: 30,),
            const SizedBox(width: 10,),
            const Text('Repositories  ', style: TextStyle(color: Colors.white30, fontSize: 25),),
            const SizedBox(width: 5,),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.indigo.shade900,
                shape: BoxShape.circle
              ),
              child: Text('${resBody["public_repos"] ?? '...'}', style: const TextStyle(color: Colors.white30, fontSize: 17),),
            ),

          ],
        ),

        Row(
          children: [
            const SizedBox(width: 20,),
            const Icon(LineIcons.user, color: Colors.grey, size: 30,),
            const SizedBox(width: 10,),
            Text(resBody["bio"] ?? '...', style: const TextStyle(color: Colors.white38, fontSize: 20, fontWeight: FontWeight.w600),),
          ],
        ),

        Row(
          children: [
            const SizedBox(width: 20,),
            const Icon(LineIcons.warehouse, color: Colors.grey, size: 30,),
            const SizedBox(width: 10,),
            Text(resBody["blog"] ?? '...', style: const TextStyle(color: Colors.white38, fontSize: 18),),
          ],
        ),
        const SizedBox(height: 10,),
        Container(
          alignment: Alignment.center,
          child: const Icon(LineIcons.github, color: Colors.grey, size: 150,),
        ),
      ],
    );
  }

}










































