import 'dart:html';
import 'package:biography/Account/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:biography/Location.dart';
import 'AboutMe.dart';
import 'StoryPage.dart';
import 'package:get_storage/get_storage.dart';
//---------------------------------------//
//---------------------------------------//
final cacheStorage=GetStorage();
void main() async{
  await GetStorage.init();
  runApp( MaterialApp(
    home: cacheStorage.read('loginEd')==true?const MyApp():const LoginScreen(),
    title: 'Biography App',
    debugShowCheckedModeBanner: false,
  ));
}
//---------------------------------------//
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}
//---------------------------------------//
class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{
  late TabController tabController;
  @override

  void initState() {
    tabController=TabController(initialIndex:cacheStorage.read("class")=="About"?2:0,length: 3,vsync: this);
    cacheStorage.read('class');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(controller: tabController,
          children:  const [Story(),Location(),AboutMe()],),
        bottomNavigationBar:  Container(color:Colors.white,
            child: TabBar(controller: tabController,
              labelColor: Color(cacheStorage.read('themeColor') ==null? 4282682111:cacheStorage.read('themeColor')),
              indicatorColor: Color(cacheStorage.read('themeColor')==null?4282682111:cacheStorage.read('themeColor')),
              unselectedLabelColor:Colors.black26 ,
              tabs:  [
                Tab(text:'Posts',icon: Icon(Icons.book,color: Color(cacheStorage.read('themeColor') ?? 4282682111),)),
                Tab(text:'Location',icon: Icon(Icons.location_pin,color: Color(cacheStorage.read('themeColor') ?? 4282682111),)),
                Tab(text:'Account',icon: Icon(Icons.account_box_sharp,color: Color(cacheStorage.read('themeColor') ?? 4282682111),))],
            )
        )
    );

  }
}
