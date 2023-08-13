
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../Empty.dart';
import '../StoryPage.dart';
//--------variable----------//
final cacheStorage = GetStorage();
int imgUrl=1;
//--------variable----------//
class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);
  @override
  State<NewPost> createState() => _NewPostState();
}
class _NewPostState extends State<NewPost> {
  TextEditingController contentController=TextEditingController();
  @override
  void initState() {
    cacheStorage.remove('Matn');
    setState(() {
      listPostContent.length;
      listPostContent.isEmpty;

    });
    super.initState();
  }
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
                    if(imgUrl>=3){
                    setState(() {
                      imgUrl=1;
                    });
                  }
                  else{
                    setState(() {
                      imgUrl+=1;
                    });
                  }},
                    child: Image(fit:BoxFit.fill,
                      image: AssetImage('assets/images/img'+(imgUrl==3?imgUrl.toString()+'.png':imgUrl.toString()+'.jpg')),),
                  )),
            ),
            Material(child:
             Container(height: 5,width: w,color: Colors.white,)),
            Material(child: SizedBox(
              width: w-10,
              child: Padding(
                padding: const EdgeInsets.only(right: 2.0,left: 8),
                child: TextFormField(
                  controller: contentController,
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
                      cacheStorage.write('Matn',contentController.text );
                      cacheStorage.write('postImage',imgUrl);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                        cacheStorage.write('class', 'story');
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
                            backgroundColor: Colors.green,
                            content: Row(textDirection: TextDirection.ltr,
                              children:const [
                                Icon(Icons.done,color: Colors.white,),
                                SizedBox(width: 10,height: 10,),
                                Text('Post created successfully',style: TextStyle(fontSize:15,color: Colors.white),),
                              ]),
                            )
                      );
                      },
                  child:Text('Add',style: TextStyle(fontFamily: 'Gilc',fontSize: w>425?22:12),),),
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
