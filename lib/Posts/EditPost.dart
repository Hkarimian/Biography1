
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../Empty.dart';
import '../StoryPage.dart';
import 'AllPost.dart';
// ignore: prefer_typing_uninitialized_variables
var activeIndex;
// ignore: prefer_typing_uninitialized_variables
var activePicture;
class GetIndexAllPosts{
  int index;
  // ignore: non_constant_identifier_names
  int Picture;

  GetIndexAllPosts(this.index, this.Picture);

  getIndex(){
    activeIndex=index;
    activePicture=Picture;
}
}
//--------variable----------//
final cacheStorage = GetStorage();
int imgUrl=1;
//--------variable----------//
class EditPost extends StatefulWidget {
  const EditPost({Key? key}) : super(key: key);
  @override
  State<EditPost> createState() => _EditPostState();
}
class _EditPostState extends State<EditPost> {
  TextEditingController textController=TextEditingController(text: listPostContent[activeIndex]);
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Material(
              child: SizedBox(width:w,height:400,
                  child:  InkWell( onTap: (){
                    if(activePicture>=3){
                    setState(() {
                      activePicture=1;
                    });
                  }
                  else{
                    setState(() {

                      activePicture+=1;
                    });
                  }},
                    child: Image(fit:BoxFit.fill,
                      image: AssetImage('assets/images/img'+(activePicture==3?activePicture.toString()+'.png':activePicture.toString()+'.jpg')),),
                  )),
            ),
            Material(child:
             Container(height: 5,width: w,color: Colors.white,)),
            Material(child: SizedBox(
              width: w-10,
              child: Padding(
                padding: const EdgeInsets.only(right: 2.0,left: 8),
                child: TextFormField(
                  controller: textController,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style:  TextStyle(fontFamily: 'Vazir',fontSize: w>425?22:16),
                keyboardType: TextInputType.text,minLines: 4,maxLines: 14,),
              ),
            )),
            Expanded(flex:1 ,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                  padding: const EdgeInsets.only(left: 15.0,top: 12),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: () {
                      cacheStorage.write('EditPost',textController.text );
                      cacheStorage.write('EditPostImage',imgUrl);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                        cacheStorage.write('class', 'edit');
                        listPostContent[activeIndex]=textController.text;
                        allRandomList[activeIndex]=activePicture;
                        return const Empty();}));
                      ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                             shape:const RoundedRectangleBorder( //<-- SEE HERE
                             side: BorderSide(
                               color: Colors.white,
                             ),
                           ),
                             duration: const Duration(seconds: 3),
                             elevation: 10,
                            backgroundColor: Colors.blueAccent,
                            content: Row(textDirection: TextDirection.ltr,
                              children:const [
                                Icon(Icons.edit,color: Colors.white,),
                                SizedBox(width: 10,height: 10,),
                                Text('Post Edited successfully',style: TextStyle(fontSize:15,color: Colors.white),),
                              ]),
                            )
                      );
                      },
                  child:Text('Update',style: TextStyle(fontFamily: 'Gilc',fontSize: w>425?22:12),),),
                ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0,top: 12),
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)),
                      onPressed: () {Navigator.of(context).pop();  },
                      child:  Text('Cancel',style: TextStyle(fontFamily: 'Gilc',fontSize: w>425?22:12),),),
                  ),
              ],),
            )
          ],),
      ),
    );
  }
}
