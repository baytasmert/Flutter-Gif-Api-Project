import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
//başla
class _MyAppState extends State<MyApp> {
var response;
var parsedResponse;
late String aranangif;
List<String> gifler= [];
  void getapi (String name)async{
    try{
   response = await http.get(Uri.parse("https://g.tenor.com/v1/search?q=$name&key=LIVDSRZULELA&limit=8"));
   parsedResponse= jsonDecode(response.body);
    print(parsedResponse);
    gifler.clear();
    for(int i = 0;i<8;i++){
    gifler.add(parsedResponse["results"][i]["media"][0]["gif"]["url"]);
    print("gif $i = ${gifler[i]}");}
    }
        catch (e){
      print(e.toString());
        }

        setState(() {

        });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getapi("welcome");
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("GIF Uygulamasi"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(

              children: [
                  TextField(onChanged: (metin){aranangif=metin;},decoration: InputDecoration(hintText: "Gıf ara"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))  ,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                onPressed: (){
                  setState(() {
                    getapi(aranangif);

                }
                );
                  }, child: Text("Ara"),
                ),
                Expanded(
                  child: Container(
                    width:MediaQuery.of(context).size.width*0.8,

                    child: gifler.isEmpty? Center(child: CircularProgressIndicator()):
                    ListView(
                      children: [
                        Container(child: Image(image: NetworkImage(gifler[0])),),
                        Container(child: Image(image: NetworkImage(gifler[1])),),
                        Container(child: Image(image: NetworkImage(gifler[2])),),
                        Container(child: Image(image: NetworkImage(gifler[3])),),
                        Container(child: Image(image: NetworkImage(gifler[4])),),
                        Container(child: Image(image: NetworkImage(gifler[5])),),
                        Container(child: Image(image: NetworkImage(gifler[6])),),
                        Container(child: Image(image: NetworkImage(gifler[7])),),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
