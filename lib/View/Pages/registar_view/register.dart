import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_app_with_getx/Controller/firebase_auth_controller.dart';
import 'package:todo_app_with_getx/View/Pages/login_view/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  bool visibility = true;

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  signUpFunction() {
    FireAuth.signUp(_emailController.value.text.trim(),
        _passwordController.value.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Register',
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
                      controller: _userNameController,
                      validator: (value) {
                        final validator = Validator(
                          validators: [const RequiredValidator()],
                        );

                        return validator.validate(
                          label: 'Required',
                          value: value,
                        );
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.orangeAccent),
                        ),
                        prefixIcon: Icon(Icons.person),
                        labelText: 'User Name',
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        final validator = Validator(
                          validators: [
                            const RequiredValidator(),
                            const EmailValidator(),
                          ],
                        );

                        return validator.validate(
                          label: 'Email',
                          value: value,
                        );
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
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        final validator = Validator(
                          validators: [
                            const RequiredValidator(),
                            const MaxLengthValidator(length: 8),
                            const MinLengthValidator(length: 4),
                          ],
                        );

                        return validator.validate(
                          label: 'Min 4 / Max 8 Length',
                          value: value,
                        );
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibility = !visibility;
                                });
                              },
                              icon: const Icon(Icons.visibility)),
                          labelText: 'Password',
                          border: const OutlineInputBorder()),
                      obscureText: visibility,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.04,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_fromKey.currentState!.validate()) {
                            print(_emailController.value.text);
                            print(_passwordController.value.text);
                            signUpFunction();
                            Get.to(const LoginPage());
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.amber,
                        ),
                        child: const Text(
                          'Register',
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
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Do you have account?')),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {}, child: const Text('Login'))),
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
