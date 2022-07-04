import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_store_app/application/stores/auth/auth_store.dart';
import 'package:test_store_app/core/Utils.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _controller = TextEditingController();
  var doValidate = false;

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0, right: 20, bottom: 10),
              child: Text(
                'Receive an email to reset your password',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            _EmailTextField(doValidate: doValidate, controller: _controller),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )),
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                ),
                onPressed: () async {
                  bool isSend = true;
                  try {
                    await authStore.resetPassword(
                        email: _controller.text.trim().toLowerCase());
                  } on FirebaseAuthException catch (e) {
                    isSend = false;
                    Utils.showSnackBar(e.message, backgroundColor: Colors.red);
                  }
                  if (!mounted) return;
                  if (isSend) {
                    Utils.showSnackBar('Password reset email sent',
                        backgroundColor: Colors.green);
                    context.router.pop();
                  } else {
                    setState(() {
                      doValidate = true;
                    });
                  }
                },
                child: const Text("Reset password"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({
    Key? key,
    required this.doValidate,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  final bool doValidate;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
          validator: (email) {
            const emailRegExp =
                r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
            return RegExp(emailRegExp).hasMatch(email ?? '')
                ? null
                : 'Email address is invalid';
          },
          autovalidateMode: doValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              filled: true,
              fillColor: const Color(0xFF9FA4AF).withOpacity(0.5),
              hintText: 'example@gmail.com',
              isDense: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
    );
  }
}
