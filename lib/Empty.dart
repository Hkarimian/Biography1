import 'dart:io';
import 'package:biography/Posts/AllPost.dart';
import 'package:biography/main.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
final cacheStorage = GetStorage();
class Empty extends StatefulWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  State<Empty> createState() => _EmptyState();
}
class _EmptyState extends State<Empty> {
  @override
  void initState() {
    () async {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        if(cacheStorage.read('class')=='story'){
          Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) { return const MyApp(); }));
          cacheStorage.remove('class');
        }
        else if(cacheStorage.read('class')=='About'){
          Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) { return const MyApp(); }));
        }
        else if(cacheStorage.read('class')=='edit'){
          Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) { return const AllPost(); }));
        }
      });
    } ();
  }
  @override
  Widget build(BuildContext context) {
    return const Center(child: SizedBox(width:50,height: 100,child: CircularProgressIndicator()));

  }
}
