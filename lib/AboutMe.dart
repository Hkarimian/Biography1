import 'dart:html';
import 'dart:ui';
import 'package:biography/Empty.dart';
import 'package:biography/StoryPage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'Account/LoginScreen.dart';
import 'Posts/EditPost.dart';
final cacheStorage=GetStorage();
class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    //--------variable----------//
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    TextEditingController aNameController=TextEditingController(text: cacheStorage.read('name'));
    TextEditingController aUserNameController=TextEditingController(text: cacheStorage.read('user'));
    TextEditingController aPassController=TextEditingController(text: cacheStorage.read('pass'));
    TextEditingController aConfPassController=TextEditingController(text: cacheStorage.read('confPas'));
    List<Color> listColor=[
      Colors.red,
      Colors.blueAccent,
      Colors.green,
      Colors.yellowAccent,
      Colors.deepOrange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.black,
    ];
    //--------variable----------//
    return  Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children:[
          Row(textDirection: TextDirection.rtl,
            children:[
            Padding(
            padding: const EdgeInsets.only(right: 15),
            child:
              //--------Tick------//
            IconButton(icon:  Icon(Icons.done,color:Color(cacheStorage.read('themeColor') ?? 4282682111),), onPressed: () {
              showDialog(
                  context: context, builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor:Color(cacheStorage.read('themeColor')==null?4282682111:cacheStorage.read('themeColor')),
                  title:Center(
                  child: Text(
                    'Warning', style: TextStyle(fontFamily: 'Gilc',color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white),),
                ),
                  content:SizedBox(
                    height: 20,
                    child: Center(
                      child: Text('Do you sure about your changes',
                          style: TextStyle(
                              fontFamily: 'Gilc', fontSize: 20,color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white)),
                    ),
                  ),
                  actions: [
                    Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                      TextButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                        child: const Text('Yes',
                            style: TextStyle(fontFamily: 'Gilc',color: Colors.white,fontSize: 20)),
                        onPressed: () {
                          if(aPassController.text!=aConfPassController.text){
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  shape:RoundedRectangleBorder( //<-- SEE HERE
                                    side: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  duration: Duration(seconds: 5),
                                  elevation: 10,
                                  backgroundColor: Colors.red,
                                  content: Row(textDirection: TextDirection.ltr,
                                      children:[
                                        Icon(Icons.report_gmailerrorred_outlined,color: Colors.white,),
                                        SizedBox(width: 10,height: 10,),
                                        Text('Passwords are not same',style: TextStyle(fontSize:20,color: Colors.white),),
                                      ]),
                                )
                            );
                          }
                          else{
                            cacheStorage.write('name',aNameController.text);
                          cacheStorage.write('user',aUserNameController.text);
                          cacheStorage.write('pass',aPassController.text);
                          cacheStorage.write('confPas',aConfPassController.text);

                          Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                shape:RoundedRectangleBorder( //<-- SEE HERE
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                duration: Duration(seconds: 5),
                                elevation: 10,
                                backgroundColor: Colors.green,
                                content: Row(textDirection: TextDirection.ltr,
                                    children:[
                                      Text('Changes are successfully',style: TextStyle(fontSize:15,color: Colors.white),),
                                      SizedBox(width: 10,height: 10,),
                                      Icon(Icons.done,color: Colors.white,),
                                    ]),
                              ),
                            );}

                        },
                      ),
                      const SizedBox(height: 25,width: 25,),
                      TextButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                        child: const Text('Cancel',
                            style: TextStyle(fontFamily: 'Gilc',color: Colors.white,fontSize: 20)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],)
                  ],);
              }
              );
            }),
              //--------Tick------//
          ),
            //---------profileImage---------//
            SizedBox(width: MediaQuery.of(context).size.width-110,
              child:  Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Material(
                    child: InkWell(
                      onTap: (){
                        cacheStorage.write('class','About');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return const Empty();
                        }));

                    },
                        hoverColor: Colors.lightBlueAccent,
                        borderRadius:const BorderRadius.all(Radius.circular(55)),
                        child:

                        InkWell(
                          onTap: (){
                            showDialog(
                              context: context, builder: (BuildContext context) {
                            return AlertDialog(backgroundColor:Colors.white,
                              title: const Center(
                                child: Text(
                                  'Pick a Picture', style: TextStyle(color: Colors.black,fontFamily: 'Gilc'),),
                              ),
                              actions: [
                                Center(
                                  child: SizedBox(
                                    width: w,
                                    height: 150,
                                    child: ListView.builder(scrollDirection: Axis.horizontal,itemCount:10,itemBuilder: (context,int index){
                                      return  InkWell(
                                          onTap: (){
                                            cacheStorage.write('profileAvatar',index);
                                            cacheStorage.write('class', 'About');
                                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>const Empty()));
                                          }
                                          ,child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                minRadius: 50,
                                        backgroundImage: AssetImage('assets/images/prof${index.toString()}''.jpg'),
                                        backgroundColor: Colors.blueGrey,

                                      ),
                                            ),
                                          ) );
                                      }),
                                  ),
                                ),
                              ],);
                          }
                          );
                          },
                          child:  CircleAvatar(
                            backgroundImage: AssetImage('assets/images/prof${cacheStorage.read('profileAvatar')==null?0:cacheStorage.read('profileAvatar').toString()}.jpg'),
                            maxRadius: 50,
                            backgroundColor: Colors.blueGrey,

                          ),
                        )


                    ),
                  ),
                ),
              ),
            ),
            //---------profileImage---------//
          ],
            ),
          Center(child: Padding(
            padding: const EdgeInsets.fromLTRB(0,10,0,15),
            child:
            Container(
              decoration:  BoxDecoration(color: Color(cacheStorage.read('themeColor') ?? 4282682111),
                borderRadius:const BorderRadius.only(
                    bottomRight:Radius.circular(0),
                    topLeft:Radius.circular(50),
                    bottomLeft:Radius.circular(0),
                    topRight:Radius.circular(50)
                ) ),

              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    SizedBox(
                      width:w/1.1,
                      child:  Directionality(textDirection: TextDirection.ltr,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,children:  [
                            //-------------Text----------------------------------------------------------//
                            Text(cacheStorage.read('user').toString(), style:TextStyle(fontFamily: 'Gilc',fontSize: 28,color: cacheStorage.read('themeColor')==4278190080?Colors.white:Colors.black,decoration: TextDecoration.none)),
                            Text(cacheStorage.read('name').toString(),style:const TextStyle(fontFamily: 'Gilc',fontSize: 20,color: Colors.white70,decoration: TextDecoration.none)),
                            //-------------Text----------------------------------------------------------//
                          ],)
                        ),
                      ),
                    ),
                  ],
                ),
                //-------------------Divider-------------------------------------//
                SizedBox(width:w/1.2,
                    child: const Divider(height: 20,color: Colors.white,thickness: 2,)
                ),
                //-------------------Divider-------------------------------------//
                //-------------------------UserField---------------------------//
                SizedBox(
                  width: w/1.2,
                  child: Material(
                    color: Colors.transparent,
                    child: Directionality(textDirection: TextDirection.ltr,
                      child: TextFormField(controller: aUserNameController,style: const TextStyle(fontFamily: 'Gilc',fontSize: 20),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          icon: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.account_circle,color: Colors.white,),
                          ),
                          labelText: 'Username',
                          labelStyle: TextStyle(fontFamily: 'Gilc',fontSize: 18),

                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ),
                //-------------------------UserField---------------------------//

                //-------------------------NameField---------------------------//
                SizedBox(width: w/1.2,
                  child: Material(
                    color: Colors.transparent,
                    child: Directionality(textDirection: TextDirection.ltr,
                      child: TextFormField(style: const TextStyle(fontFamily: 'Gilc',fontSize: 20),
                        controller: aNameController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          icon: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.account_circle,color: Colors.white,),
                          ),
                          labelText: 'Name',
                          labelStyle: TextStyle(fontFamily: 'Gilc',fontSize: 18),
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ),
                //-------------------------NameField---------------------------//

                //-------------------------PasswordField---------------------------//
                SizedBox
                  ( width: w/1.2,
                  child: Material(
                    color: Colors.transparent,
                    child: Directionality(textDirection: TextDirection.ltr,
                      child: TextFormField(
                         controller: aPassController
                         ,style: const TextStyle(fontFamily: 'Gilc',fontSize: 20),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          icon: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.vpn_key_outlined,color: Colors.white,),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(fontFamily: 'Gilc',fontSize: 18),
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ),
                //-------------------------PasswordField---------------------------//

                //-------------------------ConfirmPasswordField---------------------------//
                SizedBox( width: w/1.2,
                  child: Material(color: Colors.transparent,
                    child: Directionality(textDirection: TextDirection.ltr,
                      child: TextFormField(
                        controller: aConfPassController
                        ,style: const TextStyle(fontFamily: 'Gilc',fontSize: 20),
                        decoration: const InputDecoration(
                          //------fillcolor-------//
                          filled: true, //<-- SEE HERE
                          fillColor: Colors.white,
                          //------fillcolor-------//
                          labelText: 'ConfirmPassword',
                          labelStyle: TextStyle(fontFamily: 'Gilc',fontSize: 18),
                          icon: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.vpn_key_outlined,color: Colors.white,),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ),
                //-------------------------ConfirmPasswordField---------------------------//
                const SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.center,textDirection: TextDirection.ltr,
                  children:  [
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0,left: 25),
                      child: SizedBox(width:20,child: Icon(Icons.perm_media_outlined,color: Colors.white,)),
                    ),

                    Material(
                      child: Container(
                        color: Colors.white,
                        width: w<800?w/1.4:w/1.3-3,
                        height: 150,
                        child: listPostContent.isEmpty? SizedBox(
                            width: w<800?w/1.4:w/1.3-3,
                            height:150 ,
                            child:
                            const Center(child: Text('There is no post yet to show',style: TextStyle(fontFamily: 'Vazir',fontSize: 14,color: Colors.black),))

                        ):
                        ListView.builder(
                            scrollDirection: Axis.horizontal,itemCount:listPostContent.length,itemBuilder: (context,int index){
                          return  InkWell(onTap: (){
                            GetIndexAllPosts(index,listPostImage[index]).getIndex();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return const EditPost();
                          }));},
                              child:
                               Image(image: AssetImage('assets/images/${listPostImage[index]==3?'img3.png':'img'+listPostImage[index].toString()+'.jpg'}'),width:150,height:150));}),
                      ),
                    )
                  ],),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                   iconSwitch(5, Colors.red,0,listColor,context),
                   iconSwitch(5, Colors.blueAccent,1,listColor,context),
                   iconSwitch(5, Colors.green,2,listColor,context),
                   iconSwitch(5, Colors.yellowAccent,3,listColor,context),
                   iconSwitch(5, Colors.deepOrange,4,listColor,context),
                   iconSwitch(5, Colors.purple,5,listColor,context),
                   iconSwitch(5, Colors.pink,6,listColor,context),
                   iconSwitch(5, Colors.teal,7,listColor,context),
                    iconSwitch(5, Colors.black,8,listColor,context),
                  ],mainAxisAlignment: MainAxisAlignment.center,),
                ),
                //---------ExitButton------------//
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                    onPressed: () {
                      showDialog(
                          context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor:Color(cacheStorage.read('themeColor')==null?4282682111:cacheStorage.read('themeColor')),
                          title:Center(
                          child: Text(
                            'SignOut Alert', style: TextStyle(fontFamily: 'Gilc',color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white),),
                        ),
                          content:SizedBox(
                            height: 20,
                            child: Center(
                              child: Text('Do you sure about this',
                                  style: TextStyle(
                                      fontFamily: 'Gilc', fontSize: 20,color: cacheStorage.read('themeColor')==4294967040?Colors.black:Colors.white)),
                            ),
                          ),
                          actions: [
                            Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                              TextButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                                child: const Text('Yes',
                                    style: TextStyle(fontFamily: 'Gilc',color: Colors.white,fontSize: 20)),
                                onPressed: () {
                                  cacheStorage.write('loginEd', false);
                                  cacheStorage.remove('themeColor');
                                  Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) { return const LoginScreen(); }));
                                },
                              ),
                              const SizedBox(height: 25,width: 25,),
                              TextButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                                child: const Text('No',
                                    style: TextStyle(fontFamily: 'Gilc',color: Colors.white,fontSize: 20)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],)
                          ],);
                      }
                      );
                    },
                    child: const Text('SignOut',style: TextStyle(color: Colors.white),),),
                ),
                //---------ExitButton------------//
              ],),

              width: w/1.1,
              height: h,
            ),
          )), ],
        ),
      ),
    );
  }
}
Widget iconSwitch(double padding,Color color,int index,List<Color> ls,context){
  return Padding(
    padding: EdgeInsets.all(padding),
    child: InkWell(onTap:(){
      cacheStorage.write('class', 'About');
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
        return const Empty();}));
      cacheStorage.write('themeColor', ls[index].value);
    },child: CircleAvatar(backgroundColor: Colors.white,maxRadius: 15,child: Icon(Icons.circle,color: color,size: 30,))),
  );
}