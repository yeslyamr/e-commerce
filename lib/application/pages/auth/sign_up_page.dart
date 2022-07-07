import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:test_store_app/application/navigation/auto_router.dart';
import 'package:test_store_app/application/stores/auth/auth_store.dart';
import 'package:test_store_app/application/stores/auth/sign_up_form/sign_up_form_store.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpFormStore formStore = SignUpFormStore();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    formStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 75.0),
              //   child: Image(
              //       height:
              //           MediaQuery.of(context).size.height > 800 ? 191.0 : 150,
              //       fit: BoxFit.fill,
              //       image: const AssetImage('assets/img/logo_transparent.png')),
              // ),
              const SizedBox(height: 20),
              _UsernameTextField(formStore: formStore),
              const SizedBox(height: 10),
              _EmailTextField(formStore: formStore),
              const SizedBox(height: 10),
              PasswordTextField(formStore: formStore),
              const SizedBox(height: 30),
              _SignUpButton(formStore: formStore, authStore: authStore),
              const SizedBox(height: 20),
              _NavigateToSignInPageButton(widget: widget),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField({
    Key? key,
    required this.formStore,
  }) : super(key: key);

  final SignUpFormStore formStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
          child: Text(
            'Username',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Observer(
            builder: (_) => TextField(
              onChanged: (value) => formStore.username = value.trim(),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: const Color(0xFF9FA4AF).withOpacity(0.5),
                  hintText: 'username',
                  errorText: formStore.error.username,
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
        ),
      ],
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({
    Key? key,
    required this.formStore,
  }) : super(key: key);

  final SignUpFormStore formStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25.0, right: 20, bottom: 10),
          child: Text(
            'E-mail',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Observer(
            builder: (_) => TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => formStore.emailAddress = value.trim(),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    filled: true,
                    fillColor: const Color(0xFF9FA4AF).withOpacity(0.5),
                    hintText: 'example@gmail.com',
                    errorText: formStore.error.email,
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)))),
          ),
        ),
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.formStore,
  }) : super(key: key);

  final SignUpFormStore formStore;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var isPasswordObscure = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25.0, right: 20, bottom: 10),
          child: Text(
            'Password',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Observer(
            builder: (_) => TextField(
              obscureText: isPasswordObscure,
              onChanged: (value) => widget.formStore.password = value.trim(),
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () => setState(() {
                            isPasswordObscure = !isPasswordObscure;
                          }),
                      icon: isPasswordObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  prefixIcon: const Icon(Icons.lock),
                  filled: true,
                  fillColor: const Color(0xFF9FA4AF).withOpacity(0.5),
                  hintText: 'at least 8 characters',
                  errorText: widget.formStore.error.password,
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
        ),
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({
    Key? key,
    required this.formStore,
    required this.authStore,
  }) : super(key: key);

  final SignUpFormStore formStore;
  final AuthStore authStore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 50)),
        ),
        onPressed: () async {
          // sets up reactions for validation first time the "Sign up" button is pressed
          // And instantly validates all fields
          formStore.setupValidations();
          formStore.validateAll();

          if (formStore.canRegister) {
            await authStore.signUpWithEmailAndPassword(
                email: formStore.emailAddress,
                password: formStore.password,
                username: formStore.username);
            context.router.replace(const MainScreenRoute());
          }
        },
        child: const Text("Sign up"),
      ),
    );
  }
}

class _NavigateToSignInPageButton extends StatelessWidget {
  const _NavigateToSignInPageButton({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final SignUpPage widget;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'Already have an account? ',
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
                text: 'Sign In',
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.router.pop(
                      const SignInRoute()) //context.goNamed(AppRoutes.signInPage.name),
                )
          ]),
    );
  }
}
