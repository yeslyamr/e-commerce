import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:test_store_app/application/navigation/auto_router.dart';
import 'package:test_store_app/application/stores/auth/auth_store.dart';
import 'package:test_store_app/application/stores/auth/sign_in_form/sign_in_form_store.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInFormStore formStore = SignInFormStore();

  var isPasswordObscure = false;

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
      appBar: AppBar(title: const Text('Login')),
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
            _EmailTextField(formStore: formStore),
            const SizedBox(height: 10),
            PasswordTextField(formStore: formStore),
            const _NavigateToPasswordResetPage(),
            const SizedBox(height: 20),
            _SignInButton(formStore: formStore, authStore: authStore),
            const SizedBox(height: 20),
            const _NavigateToSignUpPageButton(),
          ],
        )),
      ),
    );
  }
}

class _NavigateToPasswordResetPage extends StatelessWidget {
  const _NavigateToPasswordResetPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () =>
                  AutoRouter.of(context).push(const PasswordResetRoute()),
              child: const Text('Forgot password?')),
        ],
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({
    Key? key,
    required this.formStore,
  }) : super(key: key);

  final SignInFormStore formStore;

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

  final SignInFormStore formStore;

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

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    Key? key,
    required this.formStore,
    required this.authStore,
  }) : super(key: key);

  final SignInFormStore formStore;
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
          // sets up reactions for validation first time the "Login" button is pressed
          // And instantly validates all fields
          formStore.setupValidations();
          formStore.validateAll();

          if (formStore.canLogin) {
            await authStore.signInWithEmailAndPassword(
              email: formStore.emailAddress,
              password: formStore.password,
            );
            context.router.replace(const MainScreenRoute());
          }
        },
        child: const Text("Login"),
      ),
    );
  }
}

class _NavigateToSignUpPageButton extends StatelessWidget {
  const _NavigateToSignUpPageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'Don\'t have an account? ',
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
                text: 'Register',
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.router.push(const SignUpRoute()))
          ]),
    );
  }
}
