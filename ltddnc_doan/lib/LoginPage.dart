import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ltddnc_doan/Homepage.dart';
import 'package:ltddnc_doan/auth.dart''';
import 'package:ltddnc_doan/register.dart';

class LoginPage extends StatefulWidget{
  const LoginPage ({super.key});

  @override
  State<LoginPage> createState() => _loginPageState();
}

class _loginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  final _formField = GlobalKey<FormState>();
  late Animation<double> _animation;
  late AnimationController _animationController;
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async{
    try{
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch(e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<bool> checkLogin() async{
    return await Auth().getCurrentUser();
  }

  Widget _errorMessage(){
    return Text(errorMessage == ''? '' :'Hmmm ? $errorMessage');
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animation.addListener(() {
      setState(() {});
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formField,
            child: Column(
              children: [
                // Padding(padding: const EdgeInsets.symmetric(vertical: 15),
                //   child: Image.asset("images_flutter/login.png"),
                // ),
                AnimatedLogo(animation: _animation),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          blurRadius: 5,
                          spreadRadius: 1
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 27,
                        color: Colors.black38,
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: 250,
                        child: TextFormField(
                          controller: _controllerEmail,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nhập email đăng nhập"
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "Vui lòng nhập email";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          blurRadius: 5,
                          spreadRadius: 1
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lock,
                        size: 27,
                        color: Colors.black38,
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: 250,
                        child: TextFormField(
                          controller: _controllerPassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nhập password"
                          ),
                          validator:(value){
                            if(value!.isEmpty){
                              return "Vui lòng nhập Password";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: (){},
                    child: const Text(
                      "Quên mật khẩu ?",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    if (_formField.currentState!.validate()){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Đang đăng nhập...")));
                    }
                    signInWithEmailAndPassword().then((value) async {
                      if (await checkLogin()) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage()));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text("Đăng nhập thành công")));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            content: Text("Đăng nhập không thành công.")));
                      }
                    }
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 1
                          ),
                        ]
                    ),child: const Text(
                    "Đăng nhập",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1
                    ),
                  ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Bạn chưa có tài khoản ? -",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RegisterPage()));
                        },
                        child: const Text("Đăng kí", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)),
                  ],
                ),
                const SizedBox(height: 20),
                _errorMessage(),
              ],
            ),
          )
        ),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  final Tween<double> _sizeAnimation = Tween<double>(begin: 0.0, end: 1.0);

  AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Opacity(
      opacity: animation.value,
      child: Image.asset("images_flutter/login.png"),
    );
  }
}