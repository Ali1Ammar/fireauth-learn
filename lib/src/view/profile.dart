import 'dart:io';

import 'package:fireauth/src/helper/pick_image.dart';
import 'package:fireauth/src/viewmodel/profile_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userStream = FirebaseAuth.instance.userChanges();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text(user.displayName ?? ""),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      if (user.photoURL != null)
                        CircleAvatar(
                          foregroundImage: NetworkImage(user.photoURL!),
                          radius: 80,
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          user.displayName!,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        user.email!,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          final viewModel = context.read<ProfileViewModel>();

                          viewModel.uploadImage();
                          setState(() {});
                        },
                        icon: const Icon(Icons.image))
                  ],
                ),
              ),
            );
          }

          return Text("error");
        });
  }
}
