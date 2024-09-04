import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/core/model/auth/pages/login_screen.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';
import 'package:todo_app/modules/layouts/manager/provider/auth_provider.dart';
import 'package:todo_app/modules/layouts/manager/provider/local_provider.dart';
import 'package:todo_app/modules/layouts/screens/settings/settings.dart';

class CreateAcountScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const String routeName = "Create";

  CreateAcountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localeProvider = LocaleProvider.get(context);

    var theme = Theme.of(context);
    return ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: Container(
          decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              image: const DecorationImage(
                  image: AssetImage("assets/images/auth.png"),
                  fit: BoxFit.cover)),
          child: Consumer<AuthProvider>(
            builder: (BuildContext context, authProvider, Widget? child) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    leading: const SizedBox(),
                    actions: [
                      TextButton(
                          onPressed: () {
                            showlanguageBottomSheet(context);
                          },
                          child: Text(
                            style: const TextStyle(color: Colors.black),
                            localeProvider.getCurrentLocale(),
                          )),
                    ]),
                backgroundColor: Colors.transparent,
                body: Form(
                  key: authProvider.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 5,
                      ),
                      Text(
                        appTranslation(context).createAccount,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D9CEC)),
                      ),
                      const Spacer(),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 12, left: 12, right: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22)),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          controller: authProvider.nameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            hintText: appTranslation(context).name,
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
                          controller: authProvider.emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            hintText: appTranslation(context).email,
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: Divider.createBorderSide(context),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF5D9CEC))),
                            filled: true,
                            contentPadding: const EdgeInsets.all(18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22)),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: authProvider.phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter  Phone number';
                            }
                            if (value.length < 11) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            hintText: appTranslation(context).phone,
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: Divider.createBorderSide(context),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF5D9CEC))),
                            filled: true,
                            contentPadding: const EdgeInsets.all(18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22)),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: authProvider.passController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          obscureText: authProvider.isSecure,
                          obscuringCharacter: "*",
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            hintText: appTranslation(context).password,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  authProvider.changeSecure();
                                },
                                icon: Icon(authProvider.isSecure
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: Divider.createBorderSide(context),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF5D9CEC))),
                            filled: true,
                            contentPadding: const EdgeInsets.all(18),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          authProvider.resetPawword();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 24, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text.rich(
                                  // textAlign: TextAlign.end,
                                  TextSpan(
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF5D9CEC)),
                                      text: "Forget Password")),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            if (authProvider.formKey.currentState?.validate() ??
                                false) {
                              authProvider.createAccount(context);
                            }
                          },
                          style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12)),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(44)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                appTranslation(context).createAccount,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF5D9CEC),
                                ),
                              ),
                              const Icon(
                                Icons.login,
                                color: Color(0xFF5D9CEC),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(18),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(
                            text: appTranslation(context).accountCheck,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          TextSpan(
                            text: appTranslation(context).login,
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                                color: Color(0xFF5D9CEC)),
                          ),
                        ])),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
