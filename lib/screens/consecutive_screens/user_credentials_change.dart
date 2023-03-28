import 'package:dream_note/logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import 'package:dream_note/logic/blocs/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:overlay_support/overlay_support.dart';

class UserCredentialsScreen extends StatelessWidget {
  const UserCredentialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    TextEditingController nameController =
        TextEditingController(text: userBloc.state.user?.name);
    TextEditingController lastNameController =
        TextEditingController(text: userBloc.state.user?.lastName);
    return Scaffold(
      appBar: DreamAppBar(),
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
                  onPressed: () {
                    if (nameController.text.isNotEmpty) {
                      if (userBloc.state.user == null) {
                        userBloc.add(
                          InitUser(
                            id: 'id',
                            name: nameController.text,
                            lastName: lastNameController.text,
                            email: 'email',
                            gender: 'gender',
                            phone: 'phone',
                            createdDate: 'createdDate',
                          ),
                        );
                      } else {
                        userBloc.add(
                          UpdateUserData(
                            userBloc.state.user!.copyWith(
                              name: nameController.text,
                              lastName: lastNameController.text,
                            ),
                          ),
                        );
                        showSimpleNotification(const Text('Профиль обновлён'));
                        Navigator.pop(context);
                      }
                    } else {
                      showSimpleNotification(const Text('Заполните имя'));
                    }
                  },
                  child: const Text('Сохранить'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DreamAppBar extends PlatformAppBar implements PreferredSizeWidget {
  DreamAppBar({
    super.key,
    super.cupertino,
    super.automaticallyImplyLeading,
    super.backgroundColor,
    super.leading,
    super.material,
    super.title,
    super.trailingActions,
    super.widgetKey,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformAppBar();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
            borderRadius: const BorderRadius.all(
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
