import 'package:fireauth/src/viewmodel/account_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * admin1@admin.com
 * aaaa@#aa1A
 * 
 */
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Selector<AccountViewModel, String?>(
                  builder: (context, error, child) {
                return Text(error ?? "");
              }, selector: ((context, viewModel) {
                return viewModel.error;
              })),
              Selector<AccountViewModel, bool>(
                  builder: (context, loading, child) {
                if (loading)
                  return const CircularProgressIndicator();
                else
                  return SizedBox();
              }, selector: ((context, viewModel) {
                return viewModel.isLoading;
              })),
              Text("Email"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: viewModel.emailController,
                  validator: (value) {
                    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value!)) return null;
                    return "must enter valid email";
                  },
                ),
              ),
              // Text("Phone"),
              // TextFormField(
              //   controller: viewModel.passwordController,
              //   inputFormatters: [LengthLimitingTextInputFormatter(10)],
              // ),
              Text("Password"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: viewModel.passwordController,
                  obscureText: true,
                  validator: (val) {
                    final regPassword =
                        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
                    if (RegExp(regPassword).hasMatch(val!)) {
                      return null;
                    }

                    return "use one small letter and one captial";
                  },
                ),
              ),
              if (isCreateAccount) ...[
                Text("Name"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: viewModel.nameController,
                  ),
                ),
              ],
              if (isCreateAccount)
                Center(
                  child: OutlinedButton(
                      onPressed: () {
                        final isOk = formKey.currentState!.validate();

                        if (!isOk) return;
                        viewModel.pressCreateButton();
                      },
                      child: Text("Create Account")),
                )
              else
                Center(
                  child: OutlinedButton(
                      onPressed: () {
                        final isOk = formKey.currentState!.validate();

                        if (!isOk) return;
                        viewModel.pressLoginButton();
                      },
                      child: Text("Login")),
                ),
              if (isCreateAccount)
                Center(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          isCreateAccount = false;
                        });
                      },
                      child: Text("ALready has account?")),
                )
              else
                Center(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          isCreateAccount = true;
                        });
                      },
                      child: Text("Does not have account?")),
                )
            ],
          ),
        ),
      ),
    );
  }
}
