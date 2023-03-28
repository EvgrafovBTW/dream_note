// ignore_for_file: prefer_const_constructors

import 'package:dream_note/logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class UserCredentialsScreen extends StatelessWidget {
  const UserCredentialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    return Scaffold(
      body: SizedBox.expand(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DreamTextField(
                  controller: nameController,
                  label: 'Ваше имя',
                  hint: 'Введите имя',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: DreamTextField(
                    controller: lastNameController,
                    label: 'Ваша фамилия',
                    hint: 'Введите фамилию',
                  ),
                ),
                PlatformElevatedButton(
                  onPressed: () {},
                  child: Text('Сохранить'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DreamTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType inputType;

  const DreamTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.inputType = TextInputType.emailAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            child: Text(
              label!,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            border: Border.all(
              color: BlocProvider.of<AppSettingsBloc>(context)
                  .state
                  .onPrimaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
          ),
        ),
      ],
    );
  }
}
