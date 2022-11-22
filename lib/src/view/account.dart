import 'package:fireauth/src/view/profile.dart';
import 'package:fireauth/src/viewmodel/account_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isCreateAccount = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AccountViewModel>();

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            Selector<AccountViewModel, User?>(selector: (context, viewModel) {
              return viewModel.currentUser;
            }, builder: (context, value, child) {
              if (value == null) return SizedBox();
              return Column(
                children: [
                  Text(value.displayName!),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProfileScreen();
                        }));
                      },
                      child: Text("go next page"))
                ],
              );
            }),
            Text("Email"),
            TextFormField(
              controller: viewModel.emailController,
              validator: (value) {
                if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value!)) return null;
                return "must enter valid email";
              },
            ),
            // Text("Phone"),
            // TextFormField(
            //   controller: viewModel.passwordController,
            //   inputFormatters: [LengthLimitingTextInputFormatter(10)],
            // ),
            Text("Password"),
            TextFormField(
              controller: viewModel.passwordController,
              validator: (val) {
                final regPassword =
                    r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
                if (RegExp(regPassword).hasMatch(val!)) {
                  return null;
                }
                return "use one small letter and one captial";
              },
            ),
            if (isCreateAccount) ...[
              Text("Name"),
              TextFormField(
                controller: viewModel.nameController,
              ),
            ],
            if (isCreateAccount)
              TextButton(
                  onPressed: () {
                    viewModel.pressButton();
                  },
                  child: Text("Create Account"))
            else
              TextButton(
                  onPressed: () {
                    viewModel.pressButton();
                  },
                  child: Text("Login")),
            if (isCreateAccount)
              TextButton(
                  onPressed: () {
                    setState(() {
                      isCreateAccount = false;
                    });
                  },
                  child: Text("ALready has account?"))
            else
              TextButton(
                  onPressed: () {
                    setState(() {
                      isCreateAccount = true;
                    });
                  },
                  child: Text("Does not have account?"))
          ],
        ),
      ),
    );
  }
}
