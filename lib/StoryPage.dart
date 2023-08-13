import 'dart:ui';
import 'package:biography/Posts/NewPost.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:biography/Posts/AllPost.dart';
//-------------------------------------//
List<String> listPostContent=[];
List<int> listPostImage=[];
final cacheStorage = GetStorage();
class Story extends StatefulWidget {
  const Story({Key? key}) : super(key: key);

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  void initState() {
    setState(() {

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //------------variable------------//
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    cacheStorage.read('Matn')==null?null:listPostContent.add(cacheStorage.read('Matn'));
    cacheStorage.read('postImage')==null?null:listPostImage.add(cacheStorage.read('postImage'));
    cacheStorage.read('Matn')!=null?cacheStorage.remove('Matn'):null;
    cacheStorage.read('postImage')!=null?cacheStorage.remove('postImage'):null;

    return Scaffold(
        appBar: AppBar(title:  Text('Biography',style: TextStyle(color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white,),),
          backgroundColor: Color(cacheStorage.read('themeColor') ==null? 4282682111:cacheStorage.read('themeColor')),
          leading:  IconButton(onPressed: (){
            showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(title: const Directionality(textDirection: TextDirection.rtl,child: Text('درباره ما',style: TextStyle(fontFamily: 'Vazir'),)),
              content: const Directionality(textDirection:TextDirection.rtl ,child: Text('تمامی حقوق این برنامه متعلق به حسین کریمیان بوده و هرگونه کپی برداری و سو استفاده پیگرد قانونی دارد',style: TextStyle(fontFamily: 'Vazir',fontSize: 15))),actions: [
                TextButton(
                  child: const Text('OK',style: TextStyle(fontFamily: 'Vazir')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],);});},icon: Icon(Icons.add_task,color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white,)),
          actions: [
            IconButton(icon:Icon(Icons.add,color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white,),
            onPressed: () {
            Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) { return const NewPost(); }));
            },),
            IconButton(icon: Icon(Icons.edit,color:cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white,),
              onPressed: () {
              ArrayRecive(listPostContent,listPostImage).swapArray();
              Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) { return const AllPost(); }));

              },),
          ],),
        body:
        listPostContent.isNotEmpty?
        ListView.builder(
            padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: listPostContent.length,
          itemBuilder: (context, index){
              return Center(child: Padding(
                padding: const EdgeInsets.fromLTRB(0,10,0,15),
                child:Container(
                  decoration:  BoxDecoration(color: Color(cacheStorage.read('themeColor')==null?4282682111:cacheStorage.read('themeColor')),
                    borderRadius:const BorderRadius.only(
                        bottomRight:Radius.circular(50),
                        topLeft:Radius.circular(50),
                        bottomLeft:Radius.circular(50),
                        topRight:Radius.circular(50)
                    )
                ),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children:    [
                        SizedBox(
                          width:250,
                          child: Directionality(textDirection: TextDirection.rtl,
                            child: ListTile(leading:
                             CircleAvatar(
                              backgroundImage: AssetImage('assets/images/prof${cacheStorage.read('profileAvatar')==null?0:cacheStorage.read('profileAvatar').toString()}'+'.jpg'),
                              backgroundColor: Colors.white,
                            ),
                              title:Text(cacheStorage.read('user'),style: TextStyle(color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white),),
                              subtitle:Text(cacheStorage.read('name'),style: TextStyle(color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white),),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width:w/1.3
                        ,child: const Divider(height: 20,color: Colors.white,thickness: 0.3,)),
                    SizedBox(
                      width:w>768?700:w/1.5 ,height: w>768?700:h/1.7,
                      child:

                      Padding(
                        padding: const EdgeInsets.only(bottom: 25,top: 25),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child:FittedBox(
                            child: Image.asset('assets/images/${listPostImage[index]==3?'img3.png':'img'+listPostImage[index].toString()+'.jpg'}'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                    ),
                    SizedBox(width:w/1.3
                        ,child: const Divider(height: 20,color: Colors.white,thickness: 2,)),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0,bottom: 20),
                      child: SizedBox(width:w/1.5,
                          child: Text(listPostContent[index],textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: w<=425?14:20,fontFamily: 'Vazir', color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white,),)),
                    ),

                  ],),
                  width: w/1.1,
                  /*height: w<=425?1000:1200*/
                ),
              ));
          })
            :
        SizedBox(
          height:h ,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
              children:[
            Center(child: Icon(Icons.add_circle_outline_rounded,size: 250,color: Colors.grey[200],)),
            const Text('there is no post yet',style: TextStyle(fontFamily: 'Gilc',fontSize: 25),)
          ]),
        )
    );


  }
}
 class SetStatus{
 bool stateVariable;
 int deleteIndex;

 SetStatus(this.stateVariable,this.deleteIndex);

  void changeStatus(){
  if(stateVariable){
    listPostContent.clear();
    listPostImage.clear();

  }
  else if(stateVariable==false&&deleteIndex>=0){

    listPostContent.removeAt(deleteIndex);
    listPostImage.removeAt(deleteIndex);
  }


  }
}
