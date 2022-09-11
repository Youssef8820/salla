// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserDataState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    texColor: Theme.of(context).hintColor,
                    labelColor: Theme.of(context).hintColor,
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name required';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                    prefColor: Theme.of(context).hintColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    texColor: Theme.of(context).hintColor,
                    labelColor: Theme.of(context).hintColor,
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Email required';
                      }
                      return null;
                    },
                    label: 'Email',
                    prefix: Icons.email,
                    prefColor: Theme.of(context).hintColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    texColor: Theme.of(context).hintColor,
                    labelColor: Theme.of(context).hintColor,
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Phone required';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                    prefColor: Theme.of(context).hintColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    text: 'update',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    function: () {
                      signOut(context);
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
