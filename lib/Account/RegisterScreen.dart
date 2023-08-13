import 'dart:html';
import 'dart:ui';
import '../main.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'package:get_storage/get_storage.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
///-------------Variables-------------------///
final cacheStorage=GetStorage();
final regForm=GlobalKey<FormState>();
TextEditingController usernameController=TextEditingController();
TextEditingController nameController=TextEditingController();
TextEditingController passController=TextEditingController();
TextEditingController confirmPassController=TextEditingController();
///-------------Variables-------------------///
class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    var w= MediaQuery.of(context).size.width;
    var h= MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Form(
        key: regForm,
        child: Container(
          height: h,width: w,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/img6.jpg'),fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Padding(
                padding: EdgeInsets.only(bottom: 32.0),
                child: Text('BiographyRegister',
                  style: TextStyle(fontFamily: 'Gilc',
                      decoration: TextDecoration.none,
                      color: Colors.green),),
              ),
              ///---------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                Material(child: SizedBox(width:w-150,
                    child: TextFormField(
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return 'Please Enter your name';
                    }
                  },
                  controller: nameController,
                    decoration:
                    const InputDecoration(
                      prefixIcon: Icon(Icons.person_pin),hintText: 'name ',
                      hintStyle: TextStyle(fontFamily: 'Gilc',
                        color: Colors.grey,
                        fontSize: 20,),
                      hintTextDirection: TextDirection.ltr,

                    ),
                ))),
              ],),
              const SizedBox(height: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                Material(child: SizedBox(width:w-150,
                    child: TextFormField(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Please enter your username!';
                      }
                    },
                    controller: usernameController,
                    decoration:
                const InputDecoration(
                  prefixIcon: Icon(Icons.person_pin_outlined),hintText: 'Username',
                  hintStyle: TextStyle(fontFamily: 'Gilc',
                    color: Colors.grey,
                    fontSize: 20,),
                  hintTextDirection: TextDirection.ltr,
                )
                )
                )
                )
              ],),
              const SizedBox(height: 2,),
              Row(mainAxisAlignment: MainAxisAlignment.center,children:  [
                Material(child: SizedBox(width:w-150,
                    child: TextFormField(
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Please enter your Password!';
                      }
                      else if(confirmPassController.text!=passController.text){
                        return 'Your Passwords are not same';
                      }
                      else if(value.length<8){
                        return 'Your password is short';
                      }
                    },
                    controller: passController,
                    decoration:
                 const InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key_sharp),hintText: 'Password',
                  hintStyle: TextStyle(fontFamily: 'Gilc',
                    color: Colors.grey,
                    fontSize: 20,),
                  hintTextDirection: TextDirection.rtl,

                ))))
              ],),
              const SizedBox(height: 2,),
              Row(mainAxisAlignment: MainAxisAlignment.center,children:  [
                Material(child: SizedBox(width:w-150,child: TextFormField(
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Please enter your Password!';
                      }
                      else if(confirmPassController.text!=passController.text){
                        return 'Your Passwords are not same';
                      }

                      else if(value.length<8){
                        return 'Your password is short';
                      }
                      else if(value.toString()==passController.text){

                      }

                    },
                    controller: confirmPassController,
                    decoration:
                const InputDecoration(prefixIcon: Icon(Icons.vpn_key_sharp),hintText: ' ConfirmPassword',
                  hintStyle: TextStyle(fontFamily: 'Gilc',
                    color: Colors.grey,
                    fontSize: 20,),
                  hintTextDirection: TextDirection.ltr,

                ))))
              ],),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: () {
                      if(regForm.currentState!.validate()){
                        cacheStorage.write('user', usernameController.value.text);
                        cacheStorage.write('name', nameController.value.text);
                        cacheStorage.write('pass', passController.value.text);
                        cacheStorage.write('confPas', confirmPassController.value.text);
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                          cacheStorage.write('loginEd', true);
                          return const MyApp();
                        }),);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          duration: const Duration(seconds: 3),
                              elevation: 10,
                              backgroundColor: Colors.green[400],
                              content: Directionality(textDirection: TextDirection.rtl,
                                  child: Text('Welcome ${usernameController.text}  ',style: const TextStyle(fontSize:22,fontFamily: 'Gilc',color: Colors.white),
                                  )
                              ),
                            ));
                      }

                    },
                    child: const Text('Register',style: TextStyle(fontSize:20,fontFamily: 'Gilc',color: Colors.white)),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return  const LoginScreen();}));
                    },
                  child: const Text('Already registered?',style: TextStyle(fontSize:25,fontFamily: 'Gilc',decoration: TextDecoration.underline),),),
              )
            ],),
        ),
      ),
    );
  }
}
