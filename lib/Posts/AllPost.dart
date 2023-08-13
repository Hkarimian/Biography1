import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../Empty.dart';
import '../StoryPage.dart';
import '../main.dart';
import 'EditPost.dart';
import 'NewPost.dart';
List allListPostContent=[];
List allRandomList=[];
class ArrayRecive{
  List listPostContent=[];
  List listPostImage=[];

  ArrayRecive(this.listPostContent, this.listPostImage);
  void swapArray(){
    allListPostContent=listPostContent;
    allRandomList=listPostImage;
  }
}

class AllPost extends StatefulWidget {
  const AllPost({Key? key}) : super(key: key);

  @override
  State<AllPost> createState() => _AllPostState();
}

class _AllPostState extends State<AllPost> {
  @override
  void initState() {
    setState(() {

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    /*bool checkboxStatus=false;*/
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    final cacheStorage=GetStorage();
    return Scaffold(
        appBar: AppBar(centerTitle: true,title:  Text('EditPost',style: TextStyle(fontFamily:'Gilc',fontSize: 25,color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white,),),
          backgroundColor: Color(cacheStorage.read('themeColor') ==null? 4282682111:cacheStorage.read('themeColor')),
          leading:  IconButton(icon: const Icon(Icons.arrow_back),color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white, onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp(),)); },),
          actions: [
            IconButton(icon: Icon(Icons.add_box_outlined,color:cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white,),
              onPressed: () {
                Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) { return const NewPost(); }));
              },),
          ],),
    body:
    listPostContent.isNotEmpty?
    ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: listPostContent.length,
    itemBuilder: (context, index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(width:w ,height: 60,decoration:BoxDecoration(color: Color(cacheStorage.read('themeColor')==null?4282682111:cacheStorage.read('themeColor')),borderRadius:BorderRadius.circular(20) ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textDirection: TextDirection.ltr,
            children:  [
           Padding(
            padding:  const EdgeInsets.all(8.0),
            child:CircleAvatar(
            backgroundImage: AssetImage('assets/images/prof${cacheStorage.read('profileAvatar')==null?0:cacheStorage.read('profileAvatar').toString()}'+'.jpg'),
            maxRadius: 20,
            backgroundColor: Colors.white,
        ),
          ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Padding(
                padding: const EdgeInsets.only(top: 0,right: 2),
                child: Text(cacheStorage.read('name'),style:  TextStyle(fontFamily: 'Gilc',fontSize: 20,color: cacheStorage.read('themeColor')==4278190080?Colors.white:Colors.black54,)),
              ),
                Padding(
                  padding: const EdgeInsets.only(top: 0,right: 2,bottom: 0),
                  child: Text(cacheStorage.read('user'),style: const TextStyle(fontFamily: 'Gilc',fontSize: 15,color: Colors.white),),
                )
              ],),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset('assets/images/${allRandomList[index]==3?'img3.png':'img'+allRandomList[index].toString()+'.jpg'}',height: 50,width: 60,),
              ),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(right: 0.0),
                       child: Text(listPostContent[index].length>30?listPostContent[index].substring(0,20)+'...':listPostContent[index],style: const TextStyle(fontFamily: 'Vazir',fontSize: 12,color: Colors.white),),
                     ),
                   ],
                 ),
               ),
              IconButton(onPressed: () {
                GetIndexAllPosts(index,allRandomList[index]).getIndex();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>const EditPost())); }, icon: const Icon(Icons.edit,color: Colors.white,),),
              IconButton(onPressed: () {
                SetStatus(false, index).changeStatus();
                cacheStorage.write('class', 'story');
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>const Empty()));
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape:const RoundedRectangleBorder( //<-- SEE HERE
                        side: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      duration: const Duration(seconds: 3),
                      elevation: 10,
                      backgroundColor: Colors.red,
                      content: Row(textDirection: TextDirection.ltr,
                          children:const [
                            Icon(Icons.delete,color: Colors.white,),
                            SizedBox(width: 10,height: 10,),
                            Text('Post deleted',style: TextStyle(fontFamily: 'Vazir',color: Colors.white),),
                          ]),
                    )
                );
                }, icon: const Icon(Icons.delete,color: Colors.white,),)
            ],),
        ),
      );
    }):SizedBox(
      height:h ,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Center(child: Icon(Icons.art_track,size: 250,color: Colors.grey[200],)),
            const Text('You don t have any post yet',style: TextStyle(fontFamily: 'Gilc',fontSize: 25),)
          ]),
    ));
  }
}
