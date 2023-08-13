import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../main.dart';
import 'RegisterScreen.dart';

final cacheStorage = GetStorage();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///---------------Form Components-----------------///
  final _lFormKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool existsValue = false;
  bool obSecurePassword = false;

  ///---------------Form Components-----------------///
  @override
  Widget build(BuildContext context) {
    ///-------------Variables-------------------///
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    ///-------------Variables-------------------///
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Form(
        key: _lFormKey,
        child: Container(
          width: w,
          height: h,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/img6.jpg'),
                  fit: BoxFit.fill)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 32.0),
                child: Text(
                  'BiographyLogin',
                  style: TextStyle(
                      fontFamily: 'Gilc',
                      decoration: TextDecoration.none,
                      color: Colors.green),
                ),
              ),

              ///---------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                      child: SizedBox(
                          width: w - 100,
                          child: TextFormField(
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            controller: userController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please insert your Username';
                              } else if (value == 'admin') {
                                cacheStorage.write('name', 'admin');
                                cacheStorage.write('user', 'admin');
                                cacheStorage.write(
                                    'pass', passwordController.text);
                                cacheStorage.write(
                                    'confPas', passwordController.text);
                              } else {
                                return 'Username is not exists';
                              }
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                fontFamily: 'Gilc',
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                              hintTextDirection: TextDirection.ltr,
                            ),
                          )
                      )
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                      child: SizedBox(
                          width: w - 100,
                          child: TextFormField(
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            controller: passwordController,
                            onChanged: (value) {
                              obSecureText(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please insert your password';
                              } else if (value == 'admin') {
                              } else {
                                userController.text = '';
                                passwordController.text = '';
                                setState(() {
                                  existsValue = false;
                                });
                                return 'Password is wrong';
                              }
                            },
                            obscureText: obSecurePassword,
                            decoration: InputDecoration(
                              fillColor: Colors.redAccent,
                              suffixIcon: existsValue == true
                                  ? IconButton(
                                icon: obSecurePassword == true
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(
                                    Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  setState(() {
                                    obSecurePassword = !obSecurePassword;
                                  });
                                },
                              )
                                  : const Icon(
                                Icons.circle,
                                color: Colors.white,
                              ),
                              prefixIcon:  const Icon(Icons.phonelink_lock),
                              hintTextDirection: TextDirection.ltr,
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                  fontFamily: 'Gilc',
                                  color: Colors.grey,
                                  fontSize: 20),
                            ),
                          )
                      )
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: () {
                      if (_lFormKey.currentState!.validate()) {
                        // Navigate the user to the Home page
                        cacheStorage.write('loginEd', true);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const MyApp();
                        }));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          duration: const Duration(seconds: 3),
                          elevation: 10,
                          backgroundColor: Colors.green[400],
                          content: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                'Welcome ${userController.value.text}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Gilc',
                                    color: Colors.white),
                              )),
                        ));
                      }
                      //
                    },
                    child: const Text('Login',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Gilc',
                            color: Colors.white)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const RegisterPage();
                    }));
                  },
                  child: const Text(
                    'Need to register?',
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Gilc',
                        decoration: TextDecoration.underline),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void obSecureText(String value) {
    if (value.isNotEmpty) {
      setState(() {
        obSecurePassword = true;
        existsValue = true;
      });
    } else if (value.isEmpty) {
      setState(() {
        existsValue = false;
        if (existsValue == false) {}
      });
    }
  }
}
