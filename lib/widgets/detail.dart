import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  // 1) Create variable to receive imdbID
  final String imdbId;

  // 2) Create constructor
  DetailPage({required this.imdbId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  // HOMEWORKKK : Call back the API on initState

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        appBar:AppBar(title:Text("Detail page")),
        body:Text("Detail Page for ${widget.imdbId}")
    );
  }
}
