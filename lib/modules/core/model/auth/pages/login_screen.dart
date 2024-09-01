import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/core/model/auth/pages/create_acount_screen.dart';
import 'package:todo_app/modules/layouts/manager/provider/auth_provider.dart';
import 'package:todo_app/modules/layouts/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "Login";
  const LoginScreen({super.key});

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
          body: Form(
            // key: _formKey,
            child: Consumer<AuthProvider>(
              builder: (BuildContext context, Provider, Widget? child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    const Text(
                      "Log In",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5D9CEC)),
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
                        // controller: emailController,
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
                        // controller: passController,
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
                          // if (_formKey.currentState != null &&
                          //     _formKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                          // }
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
                              "LogIn",
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
                              " Don't have an account..?",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF5D9CEC)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, CreateAcountScreen.routeName);
                            },
                            child: const Text(
                              " Create New",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF5D9CEC)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
