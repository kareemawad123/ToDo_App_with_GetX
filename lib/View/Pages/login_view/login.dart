import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app_with_getx/Controller/firebase_auth_controller.dart';
import 'package:todo_app_with_getx/Controller/get_controller.dart';
import 'package:todo_app_with_getx/View/Pages/registar_view/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app_with_getx/View/Pages/todo_view/todo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  final Controller controller = Get.put(Controller());
  bool visibility = true;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  signInFunction() async {
    await FireAuth.signIn(_emailController.value.text.trim(),
            _passwordController.value.text.trim())
        .then((value) {
          if(value == true){
            Fluttertoast.showToast(
                msg: "Login successfully.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            Get.to(ToDoPage());
          }else{
            print('Err: $value');
            Fluttertoast.showToast(
                msg: "$value",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // FireAuth.signOut();
    print(currentUser);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.account_circle_outlined))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.02,
            ),
            Form(
              key: _fromKey,
              child: SizedBox(
                width: size.width * 0.6,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.orangeAccent),
                        ),
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GetBuilder<Controller>(
                      builder: (controller) {
                        return TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.changeVisibility();
                                  },
                                  icon: const Icon(Icons.visibility)),
                              labelText: 'Password',
                              border: const OutlineInputBorder()),
                          obscureText: controller.visibility,
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.04,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_fromKey.currentState!.validate()) {
                            print(_emailController.value.text);
                            print(_passwordController.value.text);
                            signInFunction();
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.amber,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                                onPressed: () {},
                                child: const Text('Forget password'))),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(const RegistrationPage());
                                },
                                child: const Text('Register'))),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
