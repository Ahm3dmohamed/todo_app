import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/core/model/auth/pages/login_screen.dart';
import 'package:todo_app/modules/layouts/manager/provider/auth_provider.dart';
import 'package:todo_app/modules/layouts/screens/home_screen.dart';

class CreateAcountScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const String routeName = "Create";

  CreateAcountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Container(
        decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            image: const DecorationImage(
                image: AssetImage("assets/images/auth.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Consumer<AuthProvider>(
            builder: (BuildContext context, Provider, Widget? child) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 5,
                    ),
                    const Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5D9CEC)),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 12, left: 12, right: 12),
                      decoration: BoxDecoration(
                          // color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(22)),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        controller: Provider.nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: "Enter Your Name",
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: Divider.createBorderSide(context),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white10)),
                          filled: true,
                          contentPadding: const EdgeInsets.all(18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22)),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: Provider.emailController,
                        // validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          hintText: "Enter Your Email",
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: Divider.createBorderSide(context),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF5D9CEC))),
                          filled: true,
                          contentPadding: const EdgeInsets.all(18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22)),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: Provider.PhonePassController,
                        // validator: confirmPassword,
                        obscureText: true,

                        keyboardType: TextInputType.phone,

                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          hintText: "Phone",
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: Divider.createBorderSide(context),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF5D9CEC))),
                          filled: true,
                          contentPadding: const EdgeInsets.all(18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22)),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: Provider.passController,
                        // validator: validatePassword,
                        obscureText: Provider.isSecure,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          hintText: "Enter Your Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                Provider.changeSecure();
                              },
                              icon: Icon(Provider.isSecure
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: Divider.createBorderSide(context),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF5D9CEC))),
                          filled: true,
                          contentPadding: const EdgeInsets.all(18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            Provider.createAccount();
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName);
                          }
                        },
                        style: ButtonStyle(
                            // backgroundColor: MaterialStateProperty.all(
                            //     const Color(0xFF5D9CEC)),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 34, vertical: 18)),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(44)))),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Create Acount",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF5D9CEC),
                              ),
                            ),
                            Icon(
                              Icons.login,
                              color: Color(0xFF5D9CEC),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              "You have account...?",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF5D9CEC)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Text(
                              " Login",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF5D9CEC)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
