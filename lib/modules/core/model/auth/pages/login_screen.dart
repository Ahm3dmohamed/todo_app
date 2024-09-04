import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/core/model/auth/pages/create_acount_screen.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';
import 'package:todo_app/modules/layouts/manager/provider/auth_provider.dart';
import 'package:todo_app/modules/layouts/manager/provider/local_provider.dart';
import 'package:todo_app/modules/layouts/screens/settings/settings.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "Login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var localeProvider = LocaleProvider.get(context);

    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          image: const DecorationImage(
            image: AssetImage("assets/images/auth.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
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
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Consumer<AuthProvider>(
            builder: (BuildContext context, authProvider, Widget? child) {
              return Form(
                key: authProvider.formKey, // Use formKey for validation
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 1),
                    Text(
                      appTranslation(context).login,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5D9CEC),
                      ),
                    ),
                    const SizedBox(height: 66),
                    // Email TextFormField
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: TextFormField(
                        controller: authProvider.emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            borderSide: BorderSide(color: Color(0xFF5D9CEC)),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(18),
                        ),
                        // Add your email validation function here
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Password TextFormField
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: TextFormField(
                        controller: authProvider.passController,
                        obscureText: authProvider.isSecure,
                        obscuringCharacter: "*",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          hintText: appTranslation(context).password,
                          suffixIcon: IconButton(
                            onPressed: () {
                              authProvider.changeSecure();
                            },
                            icon: Icon(
                              authProvider.isSecure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: Divider.createBorderSide(context),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF5D9CEC)),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(18),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
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
                                        fontSize: 16, color: Color(0xFF5D9CEC)),
                                    text: "Forget Password")),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Login Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ElevatedButton(
                        onPressed: () {
                          if (authProvider.formKey.currentState?.validate() ??
                              false) {
                            authProvider.loginAccount(context);
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              appTranslation(context).login,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF5D9CEC),
                              ),
                            ),
                            const Icon(
                              Icons.login,
                              color: Color(0xFF5D9CEC),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(14),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, CreateAcountScreen.routeName);
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: appTranslation(context).notHaveAccount,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    TextSpan(
                      text: appTranslation(context).createAccount,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Color(0xFF5D9CEC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
