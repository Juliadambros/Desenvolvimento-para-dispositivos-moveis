import 'package:flutter/material.dart';

class GifPage extends StatelessWidget {
  final Map _gifData;
  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: (){
          Navigator.pop(context);
        }, 
        icon: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Image.network(
          "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif",
          fit: BoxFit.contain, height: 40,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["imagens"]["fixed_height"]["url"]),
      ),
    );

  }
}